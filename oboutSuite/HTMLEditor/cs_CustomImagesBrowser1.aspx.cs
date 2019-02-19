using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Obout.Ajax.UI.HTMLEditor;
using Obout.Ajax.UI.HTMLEditor.Popups;
using Obout.Ajax.UI.HTMLEditor.ToolbarButton;
using Obout.Ajax.UI.HTMLEditor.ContextMenu;

public partial class HTMLEditor_cs_CustomImagesBrowser1 : System.Web.UI.Page
{
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
}