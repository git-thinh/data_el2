// MC Media Player (www.mcmediaplayer.com) JavaScript File for MC 720x360, v1.10/02
// This script performs two functions:
// (1) It allows you to customize your player by editing the variables below.
// (2) It writes the HTML code which embeds the Flash media player file on your web page.

// Variables - Enter values to customize your player:
mcplayerfile = "";
checkVersion = "";
promptVersion = "";
playlist = "";
plresize = "";
plfolders = "";
mediadir = "";
dfile = "";
dfileaction = "";
defpreclip = "";
desctxtcolor = "";
descbgcolor = "";
infotype = "";
infohead = "";
infotxt = "";
infoheadcl = "";
infotxtcl = "";
infobg = "";
infobutton = "";
definfo = "";
bgcolor = "";
fullscreenmode = "";
buf = "";
zoom = "";
dlinks = "";
downloadDir = "";
showfileURLs="";
directlinkURL = "";
optmenu = "";
aseq = "";
aseqd = "";
imgdur = "";
swfdur = "";
startvol = "";
allowsearch = "";
searchorder = "";
searchdesc = "";
// Note: Resizing the player may cause distortion in the interface, especially the text.
// Only resize the player if you really need to. Default size is 720x360
playerwidth = "720";
playerheight = "360";


//////////////////////////////
// Nothing below here needs to be edited.
//////////////////////////////
qs = document.location.search;
n1 = qs.indexOf("dfile=");
if (n1 != -1) {
	n1 = n1+6;
	qs1 = qs.slice(n1);
	n2 = qs1.indexOf("&");
	if (n2 != -1) {
		qs2 = qs1.slice(0, n2);
		} else {
		qs2 = qs1;
		}
	if (qs2.length>=1) {
		dfile = qs2;
		}
}
p1 = qs.indexOf("playlist=");
if (p1 != -1) {
	p1 = p1+9;
	qs1 = qs.slice(p1);
	p2 = qs1.indexOf("&");
	if (p2 != -1) {
		qs2 = qs1.slice(0, n2);
		} else {
		qs2 = qs1;
		}
	if (qs2.length>=1) {
		playlist = qs2;
		}
}
mcflashvars = 'playlist='+playlist;
mcflashvars += '&checkVersion='+checkVersion;
mcflashvars += '&promptVersion='+promptVersion;
mcflashvars += '&plresize='+plresize;
mcflashvars += '&plfolders='+plfolders;
mcflashvars += '&mediadir='+mediadir;
mcflashvars += '&dfile='+dfile;
mcflashvars += '&dfileaction='+dfileaction;
mcflashvars += '&defpreclip='+defpreclip;
mcflashvars += '&desctxtcolor='+desctxtcolor;
mcflashvars += '&descbgcolor='+descbgcolor;
mcflashvars += '&infotype='+infotype;
mcflashvars += '&infohead='+infohead;
mcflashvars += '&infotxt='+infotxt;
mcflashvars += '&infoheadcl='+infoheadcl;
mcflashvars += '&infotxtcl='+infotxtcl;
mcflashvars += '&infobg='+infobg;
mcflashvars += '&infobutton='+infobutton;
mcflashvars += '&definfo='+definfo;
mcflashvars += '&fullscreenmode='+fullscreenmode;
mcflashvars += '&bgcolor='+bgcolor;
mcflashvars += '&buf='+buf;
mcflashvars += '&zoom='+zoom;
mcflashvars += '&dlinks='+dlinks;
mcflashvars += '&downloadDir='+downloadDir;
mcflashvars += '&showfileURLs='+showfileURLs;
mcflashvars += '&directlinkURL='+directlinkURL;
mcflashvars += '&optmenu='+optmenu;
mcflashvars += '&aseq='+aseq;
mcflashvars += '&aseqd='+aseqd;
mcflashvars += '&imgdur='+imgdur;
mcflashvars += '&swfdur='+swfdur;
mcflashvars += '&startvol='+startvol;
mcflashvars += '&allowsearch='+allowsearch;
mcflashvars += '&searchorder='+searchorder;
mcflashvars += '&searchdesc='+searchdesc;
if (!mcplayerfile) { mcplayerfile = "mcmp720x360_player.swf"; }
if (bgcolor) { divbg = bgcolor; } else { divbg = "202028"; }
mccode();
function mccode() {
	var str='';
	str+='<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http:\/\/download.macromedia.com\/pub\/shockwave\/cabs\/flash\/swflash.cab#version=7,0,19,0" width="'+playerwidth+'" height="'+playerheight+'">\n';
	str+='<param name="movie" value="'+mcplayerfile+'">';
	str+='<param name="quality" value="high">';
	str+='<param name="allowFullScreen" value="true">';
	str+='<param name="FlashVars" value="'+mcflashvars+'">\n';
	str+='<embed src="'+mcplayerfile+'" width="'+playerwidth+'" height="'+playerheight+'" quality="high" allowFullScreen="true" pluginspage="http:\/\/www.macromedia.com\/go\/getflashplayer" type="application\/x-shockwave-flash" FlashVars="'+mcflashvars+'"><\/embed>\n';
	str+='<\/object>';
	document.write(str);
}