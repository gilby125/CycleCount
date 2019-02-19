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
using Obout.Ajax.UI.HTMLEditor.ContextMenu;
using System.Collections.ObjectModel;
using System.Globalization;
using System.ComponentModel;
using System.ComponentModel.Design;

public partial class HTMLEditor_cs_ZoomButton : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        // add separator to top toolbar
        editor.TopToolbar.AddButtons.Add(new HorizontalSeparator());
        // add our custom 'Zoom' button to the the top toolbar
        editor.TopToolbar.AddButtons.Add(new ZoomButton());
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

    // Custom 'Zoom' button
    [ParseChildren(true)]
    [PersistChildren(false)]
    public class ZoomButton : DesignModeSelectButton
    {
        #region [ Properties ]

        // tooltip if not found in Localization
        public override string DefaultToolTip
        {
            get { return "Select zoom"; }
        }

        // what client-side type to initiate (it is declared in the ASPX file)
        protected override string ClientControlType
        {
            get { return "CustomToolbarButton.ZoomButton"; }
        }

        // Label of the 'Select' button if not found in Localization
        public override string DefaultLabel
        {
            get { return "Zoom"; }
        }

        // default empty option if not found in Localization
        public override string DefaultOptionText
        {
            get { return "default"; }
        }

        // options for the select
        protected override Collection<SelectOption> PreDefinedOptions
        {
            get
            {
                Collection<SelectOption> options = new Collection<SelectOption>();
                SelectOption option;

                option = new SelectOption();
                option.Value = "400%";
                option.Text = "400%";
                options.Add(option);

                option = new SelectOption();
                option.Value = "300%";
                option.Text = "300%";
                options.Add(option);

                option = new SelectOption();
                option.Value = "200%";
                option.Text = "200%";
                options.Add(option);

                option = new SelectOption();
                option.Value = "100%";
                option.Text = "100%";
                options.Add(option);

                option = new SelectOption();
                option.Value = "80%";
                option.Text = "80%";
                options.Add(option);

                option = new SelectOption();
                option.Value = "75%";
                option.Text = "75%";
                options.Add(option);

                option = new SelectOption();
                option.Value = "66%";
                option.Text = "66%";
                options.Add(option);

                option = new SelectOption();
                option.Value = "50%";
                option.Text = "50%";
                options.Add(option);

                option = new SelectOption();
                option.Value = "33%";
                option.Text = "33%";
                options.Add(option);

                option = new SelectOption();
                option.Value = "25%";
                option.Text = "25%";
                options.Add(option);

                return options;
            }
        }

        // override the default width of the select DOM element
        [Category("Appearance")]
        public override Unit SelectWidth
        {
            get { return Unit.Pixel(70); }
        }

        #endregion
    }
}