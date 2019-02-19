Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls

Partial Class SiteMap_vb_Features
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If Page.IsPostBack Then
            Page.Validate()
        End If
        SiteMap1.TreePrototype.EnableLeavesOnly = EnableLeavesOnly.Checked
        SiteMap1.TreePrototype.EnableNodeSelection = EnableNodeSelection.Checked
        If EnableServerSide.Checked Then
            AddHandler SiteMap1.TreePrototype.SelectedTreeNodeChanged, AddressOf OnNodeSelected
        End If
        If RequiredFieldValidator1.IsValid AndAlso ComparedValidator1.IsValid Then
            SiteMap1.Columns = Integer.Parse(Columns.Text)
        End If
        If RequiredFieldValidator2.IsValid AndAlso ComparedValidator2.IsValid Then
            SiteMap1.MaximumDepth = Integer.Parse(MaximumDepth.Text)
        End If
    End Sub

    Protected Sub OnNodeSelected(sender As Object, e As Obout.Ajax.UI.TreeView.NodeEventArgs)
        ScriptManager.RegisterClientScriptBlock(Me, Me.[GetType](), "Response", "setTimeout(function(){alert('Received on server: " & Convert.ToString(e.Node.Text) & "');},0);", True)
    End Sub
End Class
