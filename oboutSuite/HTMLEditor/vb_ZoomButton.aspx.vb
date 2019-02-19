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
Imports Obout.Ajax.UI.HTMLEditor.ContextMenu
Imports System.Collections.ObjectModel
Imports System.Globalization
Imports System.ComponentModel
Imports System.ComponentModel.Design

Partial Public Class HTMLEditor_vb_ZoomButton
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(sender As Object, e As EventArgs)
        ' add separator to top toolbar
        Editor.TopToolbar.AddButtons.Add(New HorizontalSeparator())
        ' add our custom 'Zoom' button to the the top toolbar
        Editor.TopToolbar.AddButtons.Add(New ZoomButton())
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If Not Page.IsPostBack Then
            Dim input As StreamReader

            input = New StreamReader(System.Web.HttpContext.Current.Server.MapPath("contents/Content1.txt"), System.Text.Encoding.ASCII)
            Editor.EditPanel.Content = input.ReadToEnd()
            input.Close()
        End If
    End Sub

    ' Custom 'Zoom' button
    <ParseChildren(True)> _
    <PersistChildren(False)> _
    Public Class ZoomButton
        Inherits DesignModeSelectButton
#Region "[ Properties ]"

        ' tooltip if not found in Localization
        Public Overrides ReadOnly Property DefaultToolTip() As String
            Get
                Return "Select zoom"
            End Get
        End Property

        ' what client-side type to initiate (it is declared in the ASPX file)
        Protected Overrides ReadOnly Property ClientControlType() As String
            Get
                Return "CustomToolbarButton.ZoomButton"
            End Get
        End Property

        ' Label of the 'Select' button if not found in Localization
        Public Overrides ReadOnly Property DefaultLabel() As String
            Get
                Return "Zoom"
            End Get
        End Property

        ' default empty option if not found in Localization
        Public Overrides ReadOnly Property DefaultOptionText() As String
            Get
                Return "default"
            End Get
        End Property

        ' options for the select
        Protected Overrides ReadOnly Property PreDefinedOptions() As Collection(Of SelectOption)
            Get
                Dim options As New Collection(Of SelectOption)()
                Dim selectOption As SelectOption

                selectOption = New SelectOption()
                selectOption.Value = "400%"
                selectOption.Text = "400%"
                options.Add(selectOption)

                selectOption = New SelectOption()
                selectOption.Value = "300%"
                selectOption.Text = "300%"
                options.Add(selectOption)

                selectOption = New SelectOption()
                selectOption.Value = "200%"
                selectOption.Text = "200%"
                options.Add(selectOption)

                selectOption = New SelectOption()
                selectOption.Value = "100%"
                selectOption.Text = "100%"
                options.Add(selectOption)

                selectOption = New SelectOption()
                selectOption.Value = "80%"
                selectOption.Text = "80%"
                options.Add(selectOption)

                selectOption = New SelectOption()
                selectOption.Value = "75%"
                selectOption.Text = "75%"
                options.Add(selectOption)

                selectOption = New SelectOption()
                selectOption.Value = "66%"
                selectOption.Text = "66%"
                options.Add(selectOption)

                selectOption = New SelectOption()
                selectOption.Value = "50%"
                selectOption.Text = "50%"
                options.Add(selectOption)

                selectOption = New SelectOption()
                selectOption.Value = "33%"
                selectOption.Text = "33%"
                options.Add(selectOption)

                selectOption = New SelectOption()
                selectOption.Value = "25%"
                selectOption.Text = "25%"
                options.Add(selectOption)

                Return options
            End Get
        End Property

        ' override the default width of the select DOM element
        <Category("Appearance")> _
        Public Overrides Property SelectWidth() As Unit
            Get
                Return Unit.Pixel(70)
            End Get
            Set(ByVal value As Unit)
            End Set
        End Property

#End Region
    End Class
End Class
