﻿Imports System.IO
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

Partial Public Class HTMLEditor_vb_HideShowButtons
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            Dim input As StreamReader

            input = New StreamReader(System.Web.HttpContext.Current.Server.MapPath("contents/Content1.txt"), System.Text.Encoding.ASCII)
            Editor.EditPanel.Content = input.ReadToEnd()
            input.Close()
        End If
        OboutCheckBox1.Text = "<img style='background-color: gray;' align='absmiddle' src='" & Page.ClientScript.GetWebResourceUrl(GetType(Obout.Ajax.UI.HTMLEditor.ToolbarButton.CommonButton), "Obout.Ajax.UI.HTMLEditor.Images.ed_format_bold_n.gif") & "' /> is shown it the top toolbar"
        OboutCheckBox2.Text = "<img style='background-color: gray;' align='absmiddle' src='" & Page.ClientScript.GetWebResourceUrl(GetType(Obout.Ajax.UI.HTMLEditor.ToolbarButton.CommonButton), "Obout.Ajax.UI.HTMLEditor.Images.ed_preview_n.gif") & "' /> is shown it the bottom toolbar"
    End Sub

    Protected Sub Submit_click(ByVal sender As Object, ByVal e As EventArgs)
        ScriptManager.RegisterClientScriptBlock(Me, Me.[GetType](), "EditorResponse", "alert('Submitted:\n\n" & Editor.EditPanel.Content.Replace("""", "\""").Replace(vbLf, "\n").Replace(vbCr, "").Replace("'", "\'") & "');", True)
    End Sub
End Class