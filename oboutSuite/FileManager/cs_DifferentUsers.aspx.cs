using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Obout.Ajax.UI;

public partial class FileManager_cs_DifferentUsers : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (UserName.Value.Length > 0)
        {
            string folder = "Images/" + UserName.Value;
            imageBrowser.GalleryFolders = imageBrowser.ManagedFolders = folder;
            imageBrowser.GalleryNames = UserName.Value;
        }
    }

    protected void OpenManager(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "response",
            "openManager()", true);
    }

    protected void fileselected_postback(object sender, EventArgs e)
    {
        Obout.Ajax.UI.FileManager.FileManager manager = sender as Obout.Ajax.UI.FileManager.FileManager;
        if (manager.FileUrl.Length > 0) // if not disabled in client-side
        {
            Result.Controls.Clear();
            Result.Controls.Add(new LiteralControl("<br /><b>Selected image:</b><br /><br />"));

            Image image = new Image();
            image.ImageUrl = manager.FileUrl;
            int width, height;
            getWidthAndHeight(int.Parse(manager.FileWidth), int.Parse(manager.FileHeight), out width, out height);
            image.Width = new Unit(width, UnitType.Pixel);
            image.Height = new Unit(height, UnitType.Pixel);
            image.AlternateText = manager.FileTitle;
            image.ToolTip = manager.FileTitle;

            Result.Controls.Add(image);
        }
    }

    static int maxWidth = 300;
    static int maxHeight = 200;
    private void getWidthAndHeight(int imageWidth, int imageHeight, out int width, out int height)
    {
        width = imageWidth;
        height = imageHeight;

        if (width > maxWidth)
        {
            height = (int)((double)height * ((double)maxWidth / (double)width));
            width = maxWidth;
        }
        if (height > maxHeight)
        {
            width = (int)((double)width * ((double)maxHeight / (double)height));
            height = maxHeight;
        }

        if (height == 0) height = 5;
        if (width == 0) width = 5;
    }
}