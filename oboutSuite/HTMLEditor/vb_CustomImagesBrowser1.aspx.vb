Imports System.Collections.Generic
Imports System.Collections.ObjectModel
Imports System.IO
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports Obout.Ajax.UI.HTMLEditor
Imports Obout.Ajax.UI.HTMLEditor.Popups
Imports Obout.Ajax.UI.HTMLEditor.ToolbarButton
Imports Obout.Ajax.UI.HTMLEditor.ContextMenu

Partial Public Class HTMLEditor_vb_CustomImagesBrowser1
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If Not Page.IsPostBack Then
            Dim input As StreamReader

            input = New StreamReader(System.Web.HttpContext.Current.Server.MapPath("contents/Content1.txt"), System.Text.Encoding.ASCII)
            editor.EditPanel.Content = input.ReadToEnd()
            input.Close()
        End If
    End Sub
End Class
