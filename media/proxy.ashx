<%@ WebHandler Language="C#" Class="proxy" %>

using System;
using System.Collections.Generic;
//using System.Linq;
using System.Web;
using System.Net;
using System.IO;
using System.Text;

public class proxy : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        string serviceUrl = string.Empty;
        if (!string.IsNullOrEmpty(context.Request.QueryString["url"]))
        {
            serviceUrl = context.Request.QueryString["url"];
        }
        else if (!string.IsNullOrEmpty(context.Request.Params["url"]))
        {
            serviceUrl = context.Request.Form["url"];
        }
        
        if(string.IsNullOrEmpty(serviceUrl))
        {
            context.Response.Write("no url given.");
            return;
        }

        string query = string.Empty;
        bool firstelement = true;

        // Copy GET vars
        foreach (string key in context.Request.QueryString)
        {
            if (key == "url") continue;
            query += (firstelement ? "?" : "&") + key + "=" + context.Request.QueryString[key];
            if (firstelement) firstelement = false;
        }

        serviceUrl = serviceUrl + query;

        HttpWebRequest client = (HttpWebRequest)WebRequest.Create(serviceUrl);
        client.KeepAlive = false;
        client.Method = context.Request.HttpMethod;
        client.ContentType = HttpContext.Current.Request.ContentType;

        // Since we pass headers through untouched, we might get compressed data back. To do anything with it we need to deflate it
        client.AutomaticDecompression = DecompressionMethods.Deflate | DecompressionMethods.GZip;

        // Copy header properties
        foreach (string headerKey in HttpContext.Current.Request.Headers.Keys)
        {
            try
            {
                client.Headers[headerKey] = HttpContext.Current.Request.Headers[headerKey];
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
        }

        // Copy POST vars
        string post_str = string.Empty;
        firstelement = true;
        foreach (string key in context.Request.Form.Keys)
        {
            if (key == "url") continue;
            post_str += (firstelement ? "" : "&") + key + "=" + context.Request.Form[key];
            firstelement = false;
        }
        if (!string.IsNullOrEmpty(post_str))
        {
            byte[] data = new ASCIIEncoding().GetBytes(post_str);
            client.ContentLength = data.Length; // fix the content length after removing the target url
            client.GetRequestStream().Write(data, 0, data.Length);
        }

        //client.GetResponse().GetResponseStream().CopyTo(context.Response.OutputStream); 
        CopyTo(client.GetResponse().GetResponseStream(), context.Response.OutputStream, 0);
    }

    //it seems 81920 is the default size in CopyTo but this can be changed
    private static void CopyTo(Stream source, Stream destination, int bufferSize)
    {
        if (bufferSize == 0) bufferSize = 81920;

        byte[] array = new byte[bufferSize];
        int count;
        while ((count = source.Read(array, 0, array.Length)) != 0)
        {
            destination.Write(array, 0, count);
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}