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
Imports Obout.Ajax.UI.HTMLEditor.ContextMenu
Imports System.Collections.ObjectModel
Imports System.Globalization


Partial Public Class HTMLEditor_vb_AddRemoveShadow
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(sender As Object, e As EventArgs)
        ' Add custom item to the context menu - make Shadow
        editor.EditPanel.ContextMenu.AddItems.Add(New AddShadowItem())
        ' Add custom item to the context menu - remove Shadow
        editor.EditPanel.ContextMenu.AddItems.Add(New RemoveShadowItem())
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If Not Page.IsPostBack Then
            Dim input As StreamReader

            input = New StreamReader(System.Web.HttpContext.Current.Server.MapPath("contents/Content1.txt"), System.Text.Encoding.ASCII)
            editor.EditPanel.Content = input.ReadToEnd()
            input.Close()
        End If
    End Sub

    ' custom 'Remove Shadow' item for context menu
    <ParseChildren(False)> _
    Public Class AddShadowItem
        Inherits DesignModeItem
#Region "[ Properties ]"

        ' what client-side type to initiate (it is declared in the ASPX file)
        Protected Overrides ReadOnly Property ClientControlType() As String
            Get
                Return "CustomContextMenu.AddShadowItem"
            End Get
        End Property

        ' element tag name
        Public NotOverridable Overrides ReadOnly Property ElementTagName() As String
            Get
                Return "img"
            End Get
        End Property

        ' image for the item
        Protected Overrides ReadOnly Property ImageSrc() As String
            Get
                Return Me.LocalResolveUrl("~/App_Obout/HTMLEditor/customButtons/ed_addShadow_n.gif")
            End Get
        End Property

        ' item text if not found in Localization
        Public Overrides ReadOnly Property DefaultToolTip() As String
            Get
                Return "Add Shadow"
            End Get
        End Property

#End Region
    End Class

    ' custom 'Remove Shadow' item for context menu
    <ParseChildren(False)> _
    Public Class RemoveShadowItem
        Inherits DesignModeItem
#Region "[ Properties ]"

        ' what client-side type to initiate (it is declared in the ASPX file)
        Protected Overrides ReadOnly Property ClientControlType() As String
            Get
                Return "CustomContextMenu.RemoveShadowItem"
            End Get
        End Property

        ' element tag name
        Public NotOverridable Overrides ReadOnly Property ElementTagName() As String
            Get
                Return "img"
            End Get
        End Property

        ' image for the item
        Protected Overrides ReadOnly Property ImageSrc() As String
            Get
                Return Me.LocalResolveUrl("~/App_Obout/HTMLEditor/customButtons/ed_removeShadow_n.gif")
            End Get
        End Property

        ' item text if not found in Localization
        Public Overrides ReadOnly Property DefaultToolTip() As String
            Get
                Return "Remove Shadow"
            End Get
        End Property

#End Region
    End Class
End Class
