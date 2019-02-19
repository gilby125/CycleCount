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
Imports Obout.Ajax.UI.HTMLEditor.Popups
Imports System.Collections.ObjectModel
Imports System.Globalization

Partial Public Class HTMLEditor_vb_InsertImageFromGallery
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(sender As Object, e As EventArgs)
        ' add separator to top toolbar
        editor.TopToolbar.AddButtons.Add(New HorizontalSeparator())
        ' add our custom 'Insert Fieldset' button to the the top toolbar
        editor.TopToolbar.AddButtons.Add(New CustomInsertImage())
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If Not Page.IsPostBack Then
            Dim input As StreamReader

            input = New StreamReader(System.Web.HttpContext.Current.Server.MapPath("contents/Content1.txt"), System.Text.Encoding.ASCII)
            Editor.EditPanel.Content = input.ReadToEnd()
            input.Close()
        End If
    End Sub

    ' Custom 'Insert Fieldset' button
    <ParseChildren(True)> _
    <PersistChildren(False)> _
    Public Class CustomInsertImage
        Inherits OpenPopupButton
#Region "[ Properties ]"

        ' tooltip if not found in Localization
        Public Overrides ReadOnly Property DefaultToolTip() As String
            Get
                Return "Insert Image from the Gallery"
            End Get
        End Property

        ' associated popup (custom popup declared below)
        Public Overrides Property RelatedPopup() As Popup
            Get
                If MyBase.RelatedPopup Is Nothing Then
                    MyBase.RelatedPopup = New ImageBrowser()
                End If
                Return MyBase.RelatedPopup
            End Get
            Protected Set(value As Popup)
            End Set
        End Property

        ' custom buttons images folder
        Protected Overrides Property ButtonImagesFolder() As String
            Get
                Return "~/App_Obout/HTMLEditor/customButtons/"
            End Get
            Set(value As String)
            End Set
        End Property

        ' base name of this button image,
        Protected Overrides ReadOnly Property BaseImageName() As String
            Get
                Return "ed_upload_image"
            End Get
        End Property

        ' what client-side type to initiate (it is declared in the ASPX file)
        Protected Overrides ReadOnly Property ClientControlType() As String
            Get
                Return "CustomToolbarButton.ImageInsert"
            End Get
        End Property

#End Region
    End Class
End Class
