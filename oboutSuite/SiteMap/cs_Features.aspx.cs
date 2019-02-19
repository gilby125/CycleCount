using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SiteMap_cs_Features : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack)
        {
            Page.Validate();
        }
        SiteMap1.TreePrototype.EnableLeavesOnly = EnableLeavesOnly.Checked;
        SiteMap1.TreePrototype.EnableNodeSelection = EnableNodeSelection.Checked;
        if (EnableServerSide.Checked)
        {
            SiteMap1.TreePrototype.SelectedTreeNodeChanged += OnNodeSelected;
        }
        if (RequiredFieldValidator1.IsValid && ComparedValidator1.IsValid)
        {
            SiteMap1.Columns = int.Parse(Columns.Text);
        }
        if (RequiredFieldValidator2.IsValid && ComparedValidator2.IsValid)
        {
            SiteMap1.MaximumDepth = int.Parse(MaximumDepth.Text);
        }
    }
    protected void OnNodeSelected(object sender, Obout.Ajax.UI.TreeView.NodeEventArgs e)
    {
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Response", "setTimeout(function(){alert('Received on server: " + e.Node.Text + "');},0);", true);
    }
}