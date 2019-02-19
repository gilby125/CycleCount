using System;
using System.IO;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Obout.Ajax.UI.HTMLEditor;
using Obout.Ajax.UI.HTMLEditor.ToolbarButton;
using Obout.Ajax.UI.HTMLEditor.Popups;
using System.Collections.ObjectModel;
using System.Globalization;

public partial class HTMLEditor_cs_InsertImageFromGallery : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        // add separator to top toolbar
        editor.TopToolbar.AddButtons.Add(new HorizontalSeparator());
        // add our custom 'Insert Fieldset' button to the the top toolbar
        editor.TopToolbar.AddButtons.Add(new CustomInsertImage());
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            StreamReader input;

            input = new StreamReader(System.Web.HttpContext.Current.Server.MapPath("contents/Content1.txt"), System.Text.Encoding.ASCII);
            editor.EditPanel.Content = input.ReadToEnd();
            input.Close();
        }
    }

    // Custom 'Insert Fieldset' button
    [ParseChildren(true)]
    [PersistChildren(false)]
    public class CustomInsertImage : OpenPopupButton
    {
        #region [ Properties ]

        // tooltip if not found in Localization
        public override string DefaultToolTip
        {
            get { return "Insert Image from the Gallery"; }
        }

        // associated popup (custom popup declared below)
        public override Popup RelatedPopup
        {
            get
            {
                if (base.RelatedPopup == null)
                {
                    base.RelatedPopup = new ImageBrowser();
                }
                return base.RelatedPopup;
            }
        }

        // custom buttons images folder
        protected override string ButtonImagesFolder
        {
            get { return "~/App_Obout/HTMLEditor/customButtons/"; }
        }

        // base name of this button image,
        protected override string BaseImageName
        {
            get { return "ed_upload_image"; }
        }

        // what client-side type to initiate (it is declared in the ASPX file)
        protected override string ClientControlType
        {
            get { return "CustomToolbarButton.ImageInsert"; }
        }

        #endregion
    }
}
