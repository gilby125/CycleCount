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
using Obout.Ajax.UI.HTMLEditor.ContextMenu;
using System.Collections.ObjectModel;
using System.Globalization;


public partial class HTMLEditor_cs_AddRemoveShadow : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        // Add custom item to the context menu - make Shadow
        editor.EditPanel.ContextMenu.AddItems.Add(new AddShadowItem());
        // Add custom item to the context menu - remove Shadow
        editor.EditPanel.ContextMenu.AddItems.Add(new RemoveShadowItem());
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

    // custom 'Remove Shadow' item for context menu
    [ParseChildren(false)]
    public class AddShadowItem : DesignModeItem
    {
        #region [ Properties ]

        // what client-side type to initiate (it is declared in the ASPX file)
        protected override string ClientControlType
        {
            get { return "CustomContextMenu.AddShadowItem"; }
        }

        // element tag name
        public sealed override string ElementTagName
        {
            get { return "img"; }
        }

        // image for the item
        protected override string ImageSrc
        {
            get { return this.LocalResolveUrl("~/App_Obout/HTMLEditor/customButtons/ed_addShadow_n.gif"); }
        }

        // item text if not found in Localization
        public override string DefaultToolTip
        {
            get { return "Add Shadow"; }
        }

        #endregion
    }

    // custom 'Remove Shadow' item for context menu
    [ParseChildren(false)]
    public class RemoveShadowItem : DesignModeItem
    {
        #region [ Properties ]

        // what client-side type to initiate (it is declared in the ASPX file)
        protected override string ClientControlType
        {
            get { return "CustomContextMenu.RemoveShadowItem"; }
        }

        // element tag name
        public sealed override string ElementTagName
        {
            get { return "img"; }
        }

        // image for the item
        protected override string ImageSrc
        {
            get { return this.LocalResolveUrl("~/App_Obout/HTMLEditor/customButtons/ed_removeShadow_n.gif"); }
        }

        // item text if not found in Localization
        public override string DefaultToolTip
        {
            get { return "Remove Shadow"; }
        }

        #endregion
    }
}