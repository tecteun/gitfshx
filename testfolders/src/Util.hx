import haxe.io.Bytes;
import haxe.io.BytesBuffer;

class Util {
    
    /**
	 * Encodes byte array to yEnc string (from SASStore).
	 * @param  {Array}  source Byte array to convert to yEnc.
	 * @return {string}        Resulting yEnc string from byte array.
	 */
	public static function yenc_encode(source: Bytes): String {
		var reserved = [0, 10, 13, 61];
		var output = '';
		var converted, ele;
		//var bytes = UInt8Array.fromBytes(source);
		var bytes = source;
		for (i in 0...Reflect.field(bytes, "length")) {
			ele = bytes.get(i);
			converted = (ele + 42) % 256;
			if (!Lambda.has(reserved, converted)) {
				output += String.fromCharCode(converted);
			} else {
				converted = (converted + 64) % 256;
				output += "=" + String.fromCharCode(converted);
			}
		}
		return output;
	}

	/**
	 * Decodes yEnc string to byte array (from SASStore).
	 * @param  {string} source yEnc string to decode to byte array.
	 * @return {Array}         Resulting byte array from yEnc string.
	 */
	public static function yenc_decode(source: String): Bytes {
		var output = new BytesBuffer();
		var ck = false;
		var c;
		for (i in 0...source.length) {
			c = source.charCodeAt(i); //fastCodeAt
			// ignore newlines
			if (c == 13 || c == 10) { continue; }
			// if we're an "=" and we haven't been flagged, set flag
			if (c == 61 && !ck) {
				ck = true;
				continue;
			}
			if (ck) {
				ck = false;
				c = c - 64;
			}
			if (c < 42 && c > 0) {
				output.addByte(c + 214);
			}
			else {
				output.addByte(c - 42);
			}
		}
		return output.getBytes();
	}
    
    public static var mimes:Dynamic = 
	{	"ai": "application/postscript",
	    "aif": "audio/x-aiff",
	    "aifc": "audio/x-aiff",
	    "aiff": "audio/x-aiff",
	    "asc": "text/plain",
	    "atom": "application/atom+xml",
	    "au": "audio/basic",
	    "avi": "video/x-msvideo",
	    "bcpio": "application/x-bcpio",
	    "bin": "application/octet-stream",
	    "bmp": "image/bmp",
	    "cdf": "application/x-netcdf",
	    "cgm": "image/cgm",
	    "class": "application/octet-stream",
	    "cpio": "application/x-cpio",
	    "cpt": "application/mac-compactpro",
	    "csh": "application/x-csh",
	    "css": "text/css",
	    "dcr": "application/x-director",
	    "dif": "video/x-dv",
	    "dir": "application/x-director",
	    "djv": "image/vnd.djvu",
	    "djvu": "image/vnd.djvu",
	    "dll": "application/octet-stream",
	    "dmg": "application/octet-stream",
	    "dms": "application/octet-stream",
	    "doc": "application/msword",
	    "docx":"application/vnd.openxmlformats-officedocument.wordprocessingml.document",
	    "dotx": "application/vnd.openxmlformats-officedocument.wordprocessingml.template",
	    "docm":"application/vnd.ms-word.document.macroEnabled.12",
	    "dotm":"application/vnd.ms-word.template.macroEnabled.12",
	    "dtd": "application/xml-dtd",
	    "dv": "video/x-dv",
	    "dvi": "application/x-dvi",
	    "dxr": "application/x-director",
	    "eps": "application/postscript",
	    "etx": "text/x-setext",
	    "exe": "application/octet-stream",
	    "ez": "application/andrew-inset",
	    "gif": "image/gif",
	    "gram": "application/srgs",
	    "grxml": "application/srgs+xml",
	    "gtar": "application/x-gtar",
	    "hdf": "application/x-hdf",
	    "hqx": "application/mac-binhex40",
		"hx": "text/x-haxe",
	    "htm": "text/html",
	    "html": "text/html",
	    "ice": "x-conference/x-cooltalk",
	    "ico": "image/x-icon",
	    "ics": "text/calendar",
	    "ief": "image/ief",
	    "ifb": "text/calendar",
	    "iges": "model/iges",
	    "igs": "model/iges",
	    "jnlp": "application/x-java-jnlp-file",
	    "jp2": "image/jp2",
	    "jpe": "image/jpeg",
	    "jpeg": "image/jpeg",
	    "jpg": "image/jpeg",
	    "js": "application/x-javascript",
	    "kar": "audio/midi",
	    "latex": "application/x-latex",
	    "lha": "application/octet-stream",
	    "lzh": "application/octet-stream",
	    "m3u": "audio/x-mpegurl",
	    "m4a": "audio/mp4a-latm",
	    "m4b": "audio/mp4a-latm",
	    "m4p": "audio/mp4a-latm",
	    "m4u": "video/vnd.mpegurl",
	    "m4v": "video/x-m4v",
	    "mac": "image/x-macpaint",
	    "man": "application/x-troff-man",
	    "mathml": "application/mathml+xml",
	    "me": "application/x-troff-me",
	    "mesh": "model/mesh",
	    "mid": "audio/midi",
	    "midi": "audio/midi",
	    "mif": "application/vnd.mif",
	    "mov": "video/quicktime",
	    "movie": "video/x-sgi-movie",
	    "mp2": "audio/mpeg",
	    "mp3": "audio/mpeg",
	    "mp4": "video/mp4",
	    "mpe": "video/mpeg",
	    "mpeg": "video/mpeg",
	    "mpg": "video/mpeg",
	    "mpga": "audio/mpeg",
	    "ms": "application/x-troff-ms",
	    "msh": "model/mesh",
	    "mxu": "video/vnd.mpegurl",
	    "nc": "application/x-netcdf",
	    "oda": "application/oda",
	    "ogg": "application/ogg",
	    "pbm": "image/x-portable-bitmap",
	    "pct": "image/pict",
	    "pdb": "chemical/x-pdb",
	    "pdf": "application/pdf",
	    "pgm": "image/x-portable-graymap",
	    "pgn": "application/x-chess-pgn",
	    "pic": "image/pict",
	    "pict": "image/pict",
	    "png": "image/png",
	    "pnm": "image/x-portable-anymap",
	    "pnt": "image/x-macpaint",
	    "pntg": "image/x-macpaint",
	    "ppm": "image/x-portable-pixmap",
	    "ppt": "application/vnd.ms-powerpoint",
	    "pptx": "application/vnd.openxmlformats-officedocument.presentationml.presentation",
	    "potx": "application/vnd.openxmlformats-officedocument.presentationml.template",
	    "ppsx": "application/vnd.openxmlformats-officedocument.presentationml.slideshow",
	    "ppam": "application/vnd.ms-powerpoint.addin.macroEnabled.12",
	    "pptm": "application/vnd.ms-powerpoint.presentation.macroEnabled.12",
	    "potm": "application/vnd.ms-powerpoint.template.macroEnabled.12",
	    "ppsm": "application/vnd.ms-powerpoint.slideshow.macroEnabled.12",
	    "ps": "application/postscript",
	    "qt": "video/quicktime",
	    "qti": "image/x-quicktime",
	    "qtif": "image/x-quicktime",
	    "ra": "audio/x-pn-realaudio",
	    "ram": "audio/x-pn-realaudio",
	    "ras": "image/x-cmu-raster",
	    "rdf": "application/rdf+xml",
	    "rgb": "image/x-rgb",
	    "rm": "application/vnd.rn-realmedia",
	    "roff": "application/x-troff",
	    "rtf": "text/rtf",
	    "rtx": "text/richtext",
	    "sgm": "text/sgml",
	    "sgml": "text/sgml",
	    "sh": "application/x-sh",
	    "shar": "application/x-shar",
	    "silo": "model/mesh",
	    "sit": "application/x-stuffit",
	    "skd": "application/x-koan",
	    "skm": "application/x-koan",
	    "skp": "application/x-koan",
	    "skt": "application/x-koan",
	    "smi": "application/smil",
	    "smil": "application/smil",
	    "snd": "audio/basic",
	    "so": "application/octet-stream",
	    "spl": "application/x-futuresplash",
	    "src": "application/x-wais-source",
	    "sv4cpio": "application/x-sv4cpio",
	    "sv4crc": "application/x-sv4crc",
	    "svg": "image/svg+xml",
	    "swf": "application/x-shockwave-flash",
	    "t": "application/x-troff",
	    "tar": "application/x-tar",
	    "tcl": "application/x-tcl",
	    "tex": "application/x-tex",
	    "texi": "application/x-texinfo",
	    "texinfo": "application/x-texinfo",
	    "tif": "image/tiff",
	    "tiff": "image/tiff",
	    "tr": "application/x-troff",
	    "tsv": "text/tab-separated-values",
	    "txt": "text/plain",
	    "ustar": "application/x-ustar",
	    "vcd": "application/x-cdlink",
	    "vrml": "model/vrml",
	    "vxml": "application/voicexml+xml",
	    "wav": "audio/x-wav",
	    "wbmp": "image/vnd.wap.wbmp",
	    "wbmxl": "application/vnd.wap.wbxml",
	    "wml": "text/vnd.wap.wml",
	    "wmlc": "application/vnd.wap.wmlc",
	    "wmls": "text/vnd.wap.wmlscript",
	    "wmlsc": "application/vnd.wap.wmlscriptc",
	    "wrl": "model/vrml",
	    "xbm": "image/x-xbitmap",
	    "xht": "application/xhtml+xml",
	    "xhtml": "application/xhtml+xml",
	    "xls": "application/vnd.ms-excel",                        
	    "xml": "application/xml",
	    "xpm": "image/x-xpixmap",
	    "xsl": "application/xml",
	    "xlsx": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
	    "xltx": "application/vnd.openxmlformats-officedocument.spreadsheetml.template",
	    "xlsm": "application/vnd.ms-excel.sheet.macroEnabled.12",
	    "xltm": "application/vnd.ms-excel.template.macroEnabled.12",
	    "xlam": "application/vnd.ms-excel.addin.macroEnabled.12",
	    "xlsb": "application/vnd.ms-excel.sheet.binary.macroEnabled.12",
	    "xslt": "application/xslt+xml",
	    "xul": "application/vnd.mozilla.xul+xml",
	    "xwd": "image/x-xwindowdump",
	    "xyz": "chemical/x-xyz",
	    "zip": "application/zip"};
}