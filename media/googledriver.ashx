<%@ WebHandler Language="C#" Class="googledriver" %>

using System;
using System.IO;
using System.Net;
using System.Web;

public class googledriver : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        HttpResponse response = context.Response;

        string serviceUrl = string.Empty;
        if (!string.IsNullOrEmpty(context.Request.QueryString["url"]))
        {
            serviceUrl = context.Request.QueryString["url"];
        }
        else if (!string.IsNullOrEmpty(context.Request.Params["url"]))
        {
            serviceUrl = context.Request.Form["url"];
        }

        if (string.IsNullOrEmpty(serviceUrl))
        {
            context.Response.Write("no url given.");
            return;
        }

        //// Check for query string
        ////string serviceUrl = Uri.UnescapeDataString(context.Request.QueryString.ToString());
        //if (string.IsNullOrEmpty(serviceUrl)) {
        //    response.StatusCode = 403;
        //    response.End();
        //    return;
        //}

        //// Filter requests
        //if (!serviceUrl.ToLowerInvariant().Contains("wikimedia.org")) {
        //    response.StatusCode = 403;
        //    response.End();
        //    return;
        //}

        // Create web request
        WebRequest webRequest = WebRequest.Create(new Uri(serviceUrl));
        webRequest.Method = context.Request.HttpMethod;

        // Send the request to the server
        WebResponse serverResponse = null;
        try {
            serverResponse = webRequest.GetResponse();
        }
        catch (WebException webExc) {
            response.StatusCode = 500;
            response.StatusDescription = webExc.Status.ToString();
            response.Write(webExc.Response);
            response.End();
            return;
        }

        // Exit if invalid response
        if (serverResponse == null) {
            response.End();
            return;
        }

        // Configure reponse
        response.ContentType = serverResponse.ContentType;
        Stream stream = serverResponse.GetResponseStream();

        byte[] buffer = new byte[32768];
        int read = 0;

        int chunk;
        while ((chunk = stream.Read(buffer, read, buffer.Length - read)) > 0) {
            read += chunk;
            if (read != buffer.Length) { continue; }
            int nextByte = stream.ReadByte();
            if (nextByte == -1) { break; }

            // Resize the buffer
            byte[] newBuffer = new byte[buffer.Length * 2];
            Array.Copy(buffer, newBuffer, buffer.Length);
            newBuffer[read] = (byte)nextByte;
            buffer = newBuffer;
            read++;
        }

        // Buffer is now too big. Shrink it.
        byte[] ret = new byte[read];
        Array.Copy(buffer, ret, read);

        response.OutputStream.Write(ret, 0, ret.Length);
        serverResponse.Close();
        stream.Close();
        response.End();
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}