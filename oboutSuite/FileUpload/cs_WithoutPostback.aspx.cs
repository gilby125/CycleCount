using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.IO;
using System.Web.UI.WebControls;
using Obout.Ajax.UI.FileUpload;

public partial class FileUpload_cs_WithoutPostback : System.Web.UI.Page, System.Web.UI.ICallbackEventHandler
{
    public string sCallBackFunctionInvocation;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string imageN = Page.Request.QueryString["getimage"];
            // if used as Image's SRC
            if (!String.IsNullOrEmpty(imageN))
            {
                if (Session["image_" + imageN] != null)
                {
                    Page.Response.ContentType = "image/gif";
                    Page.Response.BinaryWrite((byte[])Session["image_" + imageN]);
                    Page.Response.End();
                }
            }
        }
        sCallBackFunctionInvocation = Page.ClientScript.GetCallbackEventReference(this,
          "action", "processMyResult", "context", "processMyError", false);
    }

    string returnstring;

    string ICallbackEventHandler.GetCallbackResult()
    {
        return returnstring;
    }

    void ICallbackEventHandler.RaiseCallbackEvent(string eventArgument)
    {
        if (eventArgument == "saveUploadedFiles")
        {
            // here you can save the uploaded files using 'fileUpload1.PostedFiles'
            //-----------------------------------------------------------
            string images = "";
            long totalSize = 0;
            int imageN = 0;
            foreach (PostedFileInfo info in fileUpload1.PostedFiles)
            {
                Session["image_" + imageN] = getImage(info.InputStream);
                string url = Page.Request.Path;
                url += ((url.IndexOf("?") > 0) ? "&" : "?") + "getimage=" + imageN.ToString() + "&rnd=" + (new Random().Next().ToString());
                images += (imageN > 0 ? "&nbsp;" : "") + "<img alt='' src='" + url + "'>";
                totalSize += info.ContentLength;
                imageN++;
            }
            returnstring = "Uploaded " + fileUpload1.PostedFiles.Count.ToString() + " file" + (imageN > 1 ? "s" : "") + ", total size: " + totalSize.ToString() + "<br /><br />" + images;
        }
    }

    // get Thumbnail of uploaded image
    private byte[] getImage(Stream imageStream)
    {
        int maxWidth = 100;
        int maxHeight = 100;
        byte[] buf = null;

        imageStream.Position = 0;
        System.Drawing.Image objImage = System.Drawing.Image.FromStream(imageStream);

        MemoryStream imageStreamN;
        System.Drawing.Image View;
        System.Drawing.Image.GetThumbnailImageAbort myCallback = new System.Drawing.Image.GetThumbnailImageAbort(ThumbnailCallback);

        int mWidth = objImage.Width;
        int mHeight = objImage.Height;

        if (mWidth > maxWidth)
        {
            mHeight = (int)((double)mHeight * ((double)maxWidth / (double)mWidth));
            mWidth = maxWidth;
        }
        if (mHeight > maxHeight)
        {
            mWidth = (int)((double)mWidth * ((double)maxHeight / (double)mHeight));
            mHeight = maxHeight;
        }

        if (mHeight == 0) mHeight = 5;
        if (mWidth == 0) mWidth = 5;

        View = objImage.GetThumbnailImage(mWidth, mHeight, myCallback, IntPtr.Zero);
        imageStream.Close();
        imageStreamN = new MemoryStream();
        imageStreamN.Position = 0;
        View.Save(imageStreamN, objImage.RawFormat);
        View.Dispose();
        objImage.Dispose();
        imageStreamN.Position = 0;
        buf = new byte[(int)imageStreamN.Length];
        imageStreamN.Read(buf, 0, (int)imageStreamN.Length);
        imageStreamN.Close();
        return buf;
    }

    private bool ThumbnailCallback()
    {
        return false;
    }
}