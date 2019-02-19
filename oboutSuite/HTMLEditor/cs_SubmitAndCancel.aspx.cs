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
using System.Collections.ObjectModel;
using System.Globalization;

public partial class HTMLEditor_cs_SubmitAndCancel : System.Web.UI.Page
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

    protected void onCommand(object sender, CommandEventArgs e)
    {
        EditPanel editPanel = sender as EditPanel;
        // set the content from the file on 'Cancel' button click
        // (by default the previous content is restored - after the last submit)
        if (e.CommandName == "cancel")
        {
            StreamReader input;
            input = new StreamReader(System.Web.HttpContext.Current.Server.MapPath("contents/Content1.txt"), System.Text.Encoding.ASCII);
            editPanel.Content = input.ReadToEnd();
            input.Close();
        }
        // 'Submit' clicked
        if (e.CommandName == "submit")
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "response", "setTimeout(function(){alert('Submitted HTML code length: " + editPanel.Content.Length.ToString() + "');},0);", true);
        }
    }
}