
Imports System.IO
Imports System.Data
Imports System.Configuration
Imports System.Collections
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports Obout.Ajax.UI.HTMLEditor
Imports Obout.Ajax.UI.HTMLEditor.ToolbarButton
Imports System.Collections.ObjectModel
Imports System.Globalization

Partial Public Class HTMLEditor_vb_SubmitAndCancel
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If Not Page.IsPostBack Then
            Dim input As StreamReader
            input = New StreamReader(System.Web.HttpContext.Current.Server.MapPath("contents/Content1.txt"), System.Text.Encoding.ASCII)
            Editor.EditPanel.Content = input.ReadToEnd()
            input.Close()
        End If
    End Sub

    Protected Sub onCommand(sender As Object, e As CommandEventArgs)
        Dim editPanel As EditPanel = TryCast(sender, EditPanel)
        ' set the content from the file on 'Cancel' button click
        ' (by default the previous content is restored - after the last submit)
        If e.CommandName = "cancel" Then
            Dim input As StreamReader
            input = New StreamReader(System.Web.HttpContext.Current.Server.MapPath("contents/Content1.txt"), System.Text.Encoding.ASCII)
            editPanel.Content = input.ReadToEnd()
            input.Close()
        End If
        ' 'Submit' clicked
        If e.CommandName = "submit" Then
            ScriptManager.RegisterClientScriptBlock(Me, Me.[GetType](), "response", "setTimeout(function(){alert('Submitted HTML code length: " & editPanel.Content.Length.ToString() & "');},0);", True)
        End If
    End Sub
End Class