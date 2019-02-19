Imports System.Data
Imports System.Data.OleDb
Imports System.ComponentModel
Imports System.ComponentModel.Design
Imports System.ComponentModel.Design.Serialization
Imports System.Reflection
Imports System.Collections.Generic
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.HtmlControls
Imports System.Security.Permissions
Imports System.Collections
Imports System.Collections.ObjectModel
Imports System.Text
Imports System.Text.RegularExpressions
Imports System.Globalization
Imports System.IO
Imports Obout.Ajax.UI
Imports Obout.Ajax.UI.HTMLEditor
Imports Obout.Ajax.UI.HTMLEditor.ToolbarButton

<Assembly: WebResource("App_Scripts.HTMLEditor.scripts.InsertDate.js", "application/x-javascript")> 

Namespace CustomToolbarButton
    <ParseChildren(True)> _
    <PersistChildren(False)> _
    <RequiredScript(GetType(OpenPopupButton))> _
    <ButtonsList(True)> _
    <System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Maintainability", "CA1501:AvoidExcessiveInheritance")> _
    Public Class InsertIcon
        Inherits OpenPopupButton
#Region "[ Properties ]"

        Public Overrides Property RelatedPopup() As Obout.Ajax.UI.HTMLEditor.Popups.Popup
            Get
                If MyBase.RelatedPopup Is Nothing Then
                    MyBase.RelatedPopup = New CustomPopups.InsertIconPopup()
                End If
                Return MyBase.RelatedPopup
            End Get
            Protected Set(value As Obout.Ajax.UI.HTMLEditor.Popups.Popup)

            End Set
        End Property

        Protected Overrides Property ButtonImagesFolder() As String
            Get
                Return "~/App_Obout/HTMLEditor/customButtons/"
            End Get
            Set(value As String)
            End Set
        End Property

        Public Overrides ReadOnly Property DefaultToolTip() As String
            Get
                Return "Insert predefined icon"
            End Get
        End Property

        Protected Overrides ReadOnly Property BaseImageName() As String
            Get
                Return "ed_insertIcon"
            End Get
        End Property

#End Region
    End Class

    <ParseChildren(True)> _
    <PersistChildren(False)> _
    <RequiredScript(GetType(MethodButton))> _
    <ButtonsList(True)> _
    <System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Maintainability", "CA1501:AvoidExcessiveInheritance")> _
    Public Class InsertDate
        Inherits MethodButton
#Region "[ Properties ]"

        ' what client-side type to initiate
        Protected Overrides ReadOnly Property ClientControlType() As String
            Get
                Return "CustomToolbarButton.InsertDate"
            End Get
        End Property

        ' what file in the client-side type is located
        Protected Overrides Property ScriptPath() As String
            Get
                Return "~/App_Obout/HTMLEditor/Scripts/InsertDate.js"
            End Get
            Set(value As String)
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
        '
        ' The following images should be present in the folder above:
        ' ed_date_n.gif - normal button's image
        ' ed_date_a.gif - image when button pressed
        Protected Overrides ReadOnly Property BaseImageName() As String
            Get
                Return "ed_date"
            End Get
        End Property

        ' tooltip if not found in Localization
        Public Overrides ReadOnly Property DefaultToolTip() As String
            Get
                Return "Insert current date"
            End Get
        End Property

#End Region
    End Class

    '[ParseChildren(true)]
    '[PersistChildren(false)]
    '[RequiredScript(typeof(MethodButton))]
    '[ButtonsList(true)]
    '[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Maintainability", "CA1501:AvoidExcessiveInheritance")]
    'public class MakeCodeBlock : MethodButton
    '{
    '    #region [ Properties ]

    '    // what client-side type to initiate
    '    protected override string ClientControlType
    '    {
    '        get { return "CustomToolbarButton.MakeCodeBlock"; }
    '    }

    '    // what file in the client-side type is located
    '    protected override string ScriptPath
    '    {
    '        get { return "~/App_Obout/HTMLEditor/Scripts/MakeCodeBlock.js"; }
    '    }

    '    // custom buttons images folder
    '    protected override string ButtonImagesFolder
    '    {
    '        get { return "~/App_Obout/HTMLEditor/customButtons/"; }
    '    }

    '    // base name of this button image,
    '    protected override string BaseImageName
    '    {
    '        get { return "ed_MakeCodeBlock"; }
    '    }

    '    // tooltip if not found in Localization
    '    public override string DefaultToolTip
    '    {
    '        get { return "Make a code block from selected text"; }
    '    }

    '    #endregion
    '}

    <ParseChildren(True)> _
    <PersistChildren(False)> _
    <RequiredScript(GetType(OpenPopupButton))> _
    <ButtonsList(True)> _
    <System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Maintainability", "CA1501:AvoidExcessiveInheritance")> _
    Public Class MakeCodeBlock
        Inherits OpenPopupButton
#Region "[ Properties ]"

        Public Overrides Property RelatedPopup() As Obout.Ajax.UI.HTMLEditor.Popups.Popup
            Get
                If MyBase.RelatedPopup Is Nothing Then
                    MyBase.RelatedPopup = New CustomPopups.InsertCodeBlockPopup()
                End If
                Return MyBase.RelatedPopup
            End Get
            Protected Set(value As Obout.Ajax.UI.HTMLEditor.Popups.Popup)
            End Set
        End Property

        ' what client-side type to initiate
        Protected Overrides ReadOnly Property ClientControlType() As String
            Get
                Return "CustomToolbarButton.MakeCodeBlock"
            End Get
        End Property

        ' what file in the client-side type is located
        Protected Overrides Property ScriptPath() As String
            Get
                Return "~/App_Obout/HTMLEditor/Scripts/MakeCodeBlock.js"
            End Get
            Set(value As String)
            End Set
        End Property

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
                Return "ed_MakeCodeBlock"
            End Get
        End Property

        ' tooltip if not found in Localization
        Public Overrides ReadOnly Property DefaultToolTip() As String
            Get
                Return "Make a code block from selected text"
            End Get
        End Property

#End Region
    End Class

    <ParseChildren(True)> _
    <PersistChildren(False)> _
    <RequiredScript(GetType(MethodButton))> _
    <ButtonsList(True)> _
    <System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Maintainability", "CA1501:AvoidExcessiveInheritance")> _
    Public Class RemoveCodeBlock
        Inherits MethodButton
#Region "[ Properties ]"

        ' what client-side type to initiate
        Protected Overrides ReadOnly Property ClientControlType() As String
            Get
                Return "CustomToolbarButton.RemoveCodeBlock"
            End Get
        End Property

        ' what file in the client-side type is located
        Protected Overrides Property ScriptPath() As String
            Get
                Return "~/App_Obout/HTMLEditor/Scripts/RemoveCodeBlock.js"
            End Get
            Set(value As String)
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
                Return "ed_RemoveCodeBlock"
            End Get
        End Property

        ' tooltip if not found in Localization
        Public Overrides ReadOnly Property DefaultToolTip() As String
            Get
                Return "Remove the code block"
            End Get
        End Property

#End Region
    End Class

    <ParseChildren(True)> _
    <PersistChildren(False)> _
    <RequiredScript(GetType(OpenPopupButton))> _
    <ButtonsList(True)> _
    <System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Maintainability", "CA1501:AvoidExcessiveInheritance")> _
    Public MustInherit Class ImmediateFileInsert
        Inherits OpenPopupButton
#Region "[ Fields ]"

        Private _RelativeUrl As Boolean = True

#End Region

#Region "[ Properties ]"
        ''' <summary>
        ''' Gets or sets a value indicating whether to create a relative URL for selected file (image, document etc.). If false then absolute URL will be generated.
        ''' </summary>
        <DefaultValue(True)> _
        <Category("Behavior")> _
        <ExtenderControlProperty()> _
        <ClientPropertyName("relativeUrl")> _
        <Description("What URL insert: relative/absolute")> _
        Public Overridable Property RelativeUrl() As Boolean
            Get
                Return _RelativeUrl
            End Get
            Set(value As Boolean)
                _RelativeUrl = value
            End Set
        End Property

        ' folder for files uploading
        <Category("Appearance")> _
        <Description("Folder used for uploading")> _
        Public MustOverride Property UploadFolder() As String

        ' returns new GalleryManager object
        Protected MustOverride ReadOnly Property Manager() As Obout.Ajax.UI.HTMLEditor.Popups.GalleryManager

        ' what file in the client-side type is located
        Protected Overrides Property ScriptPath() As String
            Get
                Return "~/App_Obout/HTMLEditor/Scripts/ImmediateFileInsert.js"
            End Get
            Set(value As String)
            End Set
        End Property

        ' where the button's icons are stored
        Protected Overrides Property ButtonImagesFolder() As String
            Get
                Return "~/App_Obout/HTMLEditor/customButtons/"
            End Get
            Set(value As String)
            End Set
        End Property

#End Region

#Region "[ Methods ]"
        ' for client-side properties setting
        Protected Overrides Sub DescribeComponent(descriptor As ScriptComponentDescriptor)
            Dim manager__1 As Obout.Ajax.UI.HTMLEditor.Popups.GalleryManager = Manager
            ' set the client-side property - folder where to upload images
            descriptor.AddProperty("uploadFolder", LocalResolveUrl(UploadFolder))
            ' set the client-side property - class name of image browser
            descriptor.AddProperty("browserClassName", manager__1.[GetType]().AssemblyQualifiedName)
            ' set the client-side property - message when incorrect file extension for uploading is selected
            descriptor.AddProperty("invalidFileExtensionMessage", manager__1.InvalidFileExtensionMessage)
            ' set the client-side property - semicolon seperated available extensions for images
            descriptor.AddProperty("availableExtensions", manager__1.AvailableExtensions)
            ' get the root of the site
            descriptor.AddProperty("httpRoot", Obout.Ajax.UI.HTMLEditor.Popups.GalleryManager.GetHttpRoot(Page))
            ' call the base method
            MyBase.DescribeComponent(descriptor)
        End Sub
#End Region
    End Class

    Public Class ImmediateImageInsert
        Inherits ImmediateFileInsert
#Region "[ Properties ]"

        ' folder for images uploading
        <DefaultValue("~/App_Obout/HTMLEditor/ImageGallery/users_images/")> _
        Public Overrides Property UploadFolder() As String
            Get
                Return DirectCast(If(ViewState("UploadFolder"), "~/App_Obout/HTMLEditor/ImageGallery/users_images/"), String)
            End Get
            Set(value As String)
                ViewState("UploadFolder") = value
            End Set
        End Property

        ' we already have an embedded images uploader, use it
        Public Overrides Property RelatedPopup() As Obout.Ajax.UI.HTMLEditor.Popups.Popup
            Get
                If MyBase.RelatedPopup Is Nothing Then
                    MyBase.RelatedPopup = New Obout.Ajax.UI.HTMLEditor.Popups.UploadImagePopup()
                End If
                Return MyBase.RelatedPopup
            End Get
            Protected Set(value As Obout.Ajax.UI.HTMLEditor.Popups.Popup)
            End Set
        End Property

        ' tooltip if not found in localization
        Public Overrides ReadOnly Property DefaultToolTip() As String
            Get
                Return "Image uploading with immediate inserting"
            End Get
        End Property

        ' base name of the icon
        Protected Overrides ReadOnly Property BaseImageName() As String
            Get
                Return "ed_upload_image"
            End Get
        End Property

        Protected Overrides ReadOnly Property Manager() As Obout.Ajax.UI.HTMLEditor.Popups.GalleryManager
            Get
                Return New Obout.Ajax.UI.HTMLEditor.Popups.ImageBrowser()
            End Get
        End Property

        ' what client-side type to initiate
        Protected Overrides ReadOnly Property ClientControlType() As String
            Get
                Return "CustomToolbarButton.ImmediateImageInsert"
            End Get
        End Property

#End Region
    End Class
    Public Class ImmediateDocumentInsert
        Inherits ImmediateFileInsert
#Region "[ Properties ]"

        ' folder for images uploading
        <DefaultValue("~/App_Obout/HTMLEditor/DocumentsGallery/users_documents/")> _
        Public Overrides Property UploadFolder() As String
            Get
                Return DirectCast(If(ViewState("UploadFolder"), "~/App_Obout/HTMLEditor/DocumentsGallery/users_documents/"), String)
            End Get
            Set(value As String)
                ViewState("UploadFolder") = value
            End Set
        End Property

        ' we already have an embedded images uploader, use it
        Public Overrides Property RelatedPopup() As Obout.Ajax.UI.HTMLEditor.Popups.Popup
            Get
                If MyBase.RelatedPopup Is Nothing Then
                    MyBase.RelatedPopup = New Obout.Ajax.UI.HTMLEditor.Popups.UploadDocumentPopup()
                End If
                Return MyBase.RelatedPopup
            End Get
            Protected Set(value As Obout.Ajax.UI.HTMLEditor.Popups.Popup)
            End Set
        End Property

        ' tooltip if not found in localization
        Public Overrides ReadOnly Property DefaultToolTip() As String
            Get
                Return "Document uploading with immediate inserting"
            End Get
        End Property

        ' base name of the icon
        Protected Overrides ReadOnly Property BaseImageName() As String
            Get
                Return "ed_upload_document"
            End Get
        End Property

        Protected Overrides ReadOnly Property Manager() As Obout.Ajax.UI.HTMLEditor.Popups.GalleryManager
            Get
                Return New Obout.Ajax.UI.HTMLEditor.Popups.UrlBrowser()
            End Get
        End Property

        ' what client-side type to initiate
        Protected Overrides ReadOnly Property ClientControlType() As String
            Get
                Return "CustomToolbarButton.ImmediateDocumentInsert"
            End Get
        End Property

#End Region
    End Class

    Public Class ImmediateImageInsertToDb
        Inherits ImmediateImageInsert
#Region "[ Properties ]"
        <DefaultValue("ImageStream.aspx?ID=")> _
        Public Overrides Property UploadFolder() As String
            Get
                Return DirectCast(If(ViewState("UploadFolder"), "ImageStream.aspx?ID="), String)
            End Get
            Set(value As String)
                ViewState("UploadFolder") = value
            End Set
        End Property
        Protected Overrides ReadOnly Property Manager() As Obout.Ajax.UI.HTMLEditor.Popups.GalleryManager
            Get
                Return New CustomPopups.ImageBrowserForInsertToDb()
            End Get
        End Property
#End Region
    End Class
End Namespace

Namespace CustomPopups
    Public Class ImageBrowserForInsertToDb
        Inherits Obout.Ajax.UI.HTMLEditor.Popups.ImageBrowser
        ' Virtual path of the database
        Protected Overridable ReadOnly Property DbPath() As String
            Get
                Return "~/App_Data/FilesRepository.mdb"
            End Get
        End Property

        ' [19.10.2010 7:43:02] ilyabutorine: connect timeout=3600;server=OBOUTDB\OBOUTDB;database=obout_site;uid=oboutPublic;pwd=kl3$08
        ' [19.10.2010 7:43:26] ilyabutorine: table names:  Editor_tbFolder, Editor_tbImage
        ' Connection string
        Protected Overridable ReadOnly Property ConnectionString() As String
            Get
                Return "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & System.Web.HttpContext.Current.Server.MapPath(ResolveUrl(DbPath)) & ";"
            End Get
        End Property

        ' OleDbCommand for SELECT @@IDENTITY statement
        Private cmdGetIdentity As OleDbCommand

        ' override the 'Save uploaded file' method
        Protected Overrides Function SaveUploadedFile(folder As String, name As String, title As String, stream As Stream) As String
            Dim returnId As String = ""
            Dim connection As New OleDbConnection()
            Try
                connection.ConnectionString = ConnectionString
                connection.Open()
                Dim folderId As Integer = 0
                ' root folder
                Dim sqlString As String = "Select * from tbImage Where fldFolderId=" & folderId.ToString() & " AND fldName=""" & name & """"
                Dim eAdapter As New OleDbDataAdapter(sqlString, connection)
                Dim eTable As New DataTable()
                eAdapter.Fill(eTable)

                ' Delete the duplicate if it is present
                If eTable.Rows.Count > 0 Then
                    Dim myComm As New OleDbCommand("DELETE FROM tbImage Where fldFolderId=" & folderId.ToString() & " AND fldName=""" & name & """", connection)
                    myComm.ExecuteNonQuery()
                End If

                eAdapter.Dispose()
                eTable.Dispose()

                sqlString = "Select * from tbImage Where fldFolderId=" & folderId.ToString()
                eAdapter = New OleDbDataAdapter(sqlString, connection)
                eTable = New DataTable()
                eAdapter.Fill(eTable)

                Dim cmdInsert As New OleDbCommand("INSERT INTO tbImage (fldName, fldFolderId, fldDescription, fldContent) VALUES(?, ?, ?, ?)", connection)
                cmdInsert.Parameters.Add(New OleDbParameter("fldName", OleDbType.VarChar, 50, "fldName"))
                cmdInsert.Parameters.Add(New OleDbParameter("fldFolderId", OleDbType.[Integer], 0, "fldFolderId"))
                cmdInsert.Parameters.Add(New OleDbParameter("fldDescription", OleDbType.VarChar, 100, "fldDescription"))
                cmdInsert.Parameters.Add(New OleDbParameter("fldContent", OleDbType.Binary, 0, "fldContent"))
                eAdapter.InsertCommand = cmdInsert

                ' Create a command to get IDENTITY Value
                cmdGetIdentity = New OleDbCommand("SELECT @@IDENTITY", connection)

                AddHandler eAdapter.RowUpdated, New OleDbRowUpdatedEventHandler(AddressOf HandleRowUpdated)

                Dim newRow As DataRow = eTable.NewRow()
                newRow("fldName") = name
                newRow("fldFolderId") = folderId
                newRow("fldDescription") = title
                Dim content As Byte() = New Byte(stream.Length - 1) {}
                stream.Read(content, 0, CInt(stream.Length))
                newRow("fldContent") = content

                eTable.Rows.Add(newRow)
                eAdapter.Update(eTable)
                returnId = newRow("id").ToString()

                ' Release the Resources
                cmdInsert = Nothing
                cmdGetIdentity = Nothing
                eAdapter.Dispose()
                eTable.Dispose()
            Finally
                connection.Close()
                connection.Dispose()
            End Try
            Return returnId
        End Function

        ' Event Handler for RowUpdated Event
        Private Sub HandleRowUpdated(sender As Object, e As OleDbRowUpdatedEventArgs)
            If e.Status = UpdateStatus.[Continue] AndAlso e.StatementType = StatementType.Insert Then
                ' Get the Identity column value
                e.Row("id") = Int32.Parse(cmdGetIdentity.ExecuteScalar().ToString())
                e.Row.AcceptChanges()
            End If
        End Sub

        ' get image's content
        Public Function GetImageBytes(id As Integer) As Byte()
            Dim content As Byte() = Nothing
            Dim connection As New OleDbConnection()
            Try
                connection.ConnectionString = ConnectionString
                connection.Open()
                Dim sqlString As String = "Select * from tbImage Where id=" & id.ToString()
                Dim eAdapter As New OleDbDataAdapter(sqlString, connection)
                Dim eTable As New DataTable()
                eAdapter.Fill(eTable)

                If eTable.Rows.Count > 0 Then
                    content = DirectCast(eTable.Rows(0)("fldContent"), Byte())
                End If

                eAdapter.Dispose()
                eTable.Dispose()
            Finally
                connection.Close()
                connection.Dispose()
            End Try
            Return content
        End Function
    End Class

    <RequiredScript(GetType(Obout.Ajax.UI.HTMLEditor.Popups.Popup))> _
    <System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Maintainability", "CA1501:AvoidExcessiveInheritance")> _
    Public Class InsertIconPopup
        Inherits Obout.Ajax.UI.HTMLEditor.Popups.Popup

#Region "[ Properties ]"

        <DefaultValue(10)> _
        <Category("Appearance")> _
        <Description("Icons in one row")> _
        Public Property IconsInRow() As Integer
            Get
                Return CInt(If(ViewState("IconsInRow"), 10))
            End Get
            Set(value As Integer)
                ViewState("IconsInRow") = value
            End Set
        End Property

        <DefaultValue("~/App_Obout/HTMLEditor/icons/")> _
        <Category("Appearance")> _
        <Description("Folder used for icons")> _
        Public Property IconsFolder() As String
            Get
                Return DirectCast(If(ViewState("IconsFolder"), "~/App_Obout/HTMLEditor/icons/"), String)
            End Get
            Set(value As String)
                ViewState("IconsFolder") = value
            End Set
        End Property

        Protected Overrides Property ScriptPath() As String
            Get
                Return "~/App_Obout/HTMLEditor/Scripts/InsertIconPopup.js"
            End Get
            Set(value As String)
            End Set
        End Property

#End Region

        Protected Overrides ReadOnly Property ClientControlType() As String
            Get
                Return "CustomPopup.InsertIconPopup"
            End Get
        End Property

#Region "[ Methods ]"

        Protected Overrides Sub FillContent()
            Dim table As New Table()
            Dim row As TableRow = Nothing
            Dim cell As TableCell

            Dim iconsFolder As String = LocalResolveUrl(Me.IconsFolder)
            If iconsFolder.Length > 0 Then
                Dim lastCh As String = iconsFolder.Substring(iconsFolder.Length - 1, 1)
                If lastCh <> "\" AndAlso lastCh <> "/" Then
                    iconsFolder += "/"
                End If
            End If

            If Directory.Exists(System.Web.HttpContext.Current.Server.MapPath(iconsFolder)) Then
                Dim files As String() = Directory.GetFiles(System.Web.HttpContext.Current.Server.MapPath(iconsFolder))
                Dim j As Integer = 0

                For Each file As String In files
                    Dim ext As String = Path.GetExtension(file).ToLower()
                    If ext = ".gif" OrElse ext = ".jpg" OrElse ext = ".jpeg" OrElse ext = ".png" Then
                        If j = 0 Then
                            row = New TableRow()
                            table.Rows.Add(row)
                        End If
                        cell = New TableCell()
                        Dim image As New System.Web.UI.WebControls.Image()
                        image.ImageUrl = iconsFolder & Path.GetFileName(file)
                        image.Attributes.Add("onmousedown", "insertImage(""" & iconsFolder & Path.GetFileName(file) & """)")
                        image.Style(HtmlTextWriterStyle.Cursor) = "pointer"
                        cell.Controls.Add(image)
                        row.Cells.Add(cell)

                        j += 1
                        If j = IconsInRow Then
                            j = 0
                        End If
                    End If
                Next
            End If
            table.Attributes.Add("border", "0")
            table.Attributes.Add("cellspacing", "2")
            table.Attributes.Add("cellpadding", "0")
            table.Style("background-color") = "transparent"

            Content.Add(table)
        End Sub

#End Region
    End Class

    <RequiredScript(GetType(Obout.Ajax.UI.HTMLEditor.Popups.Popup))> _
    <System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Maintainability", "CA1501:AvoidExcessiveInheritance")> _
    Public Class InsertCodeBlockPopup
        Inherits Obout.Ajax.UI.HTMLEditor.Popups.Popup

#Region "[ Properties ]"

        <DefaultValue("cs;vb;js;xml;html;css")> _
        <Category("Appearance")> _
        <Description("Folder used for icons")> _
        Public Property SupportedLanguages() As String
            Get
                Return DirectCast(If(ViewState("SupportedLanguages"), "cs;vb;js;xml;html;css"), String)
            End Get
            Set(value As String)
                ViewState("SupportedLanguages") = value
            End Set
        End Property

        Protected Overrides Property ScriptPath() As String
            Get
                Return "~/App_Obout/HTMLEditor/Scripts/InsertCodeBlockPopup.js"
            End Get
            Set(value As String)
            End Set
        End Property

#End Region

        Protected Overrides ReadOnly Property ClientControlType() As String
            Get
                Return "CustomPopup.InsertCodeBlockPopup"
            End Get
        End Property

#Region "[ Methods ]"

        Protected Overrides Sub FillContent()
            Dim table As New Table()
            Dim row As TableRow = Nothing
            Dim cell As TableCell

            Dim names As String() = SupportedLanguages.Split(New Char() {";"c})

            For Each name As String In names
                row = New TableRow()
                table.Rows.Add(row)
                cell = New TableCell()
                cell.Controls.Add(New LiteralControl(name.ToUpper()))
                cell.Attributes.Add("onmousedown", "insertCodeBlock(this)")
                cell.Attributes.Add("onmouseover", "this.style.backgroundColor='Blue';this.style.color='White';")
                cell.Attributes.Add("onmouseout", "this.style.backgroundColor='Transparent';this.style.color='Blue';")
                cell.Attributes.Add("onmousedown", "insertCodeBlock(this); return false;")
                cell.Style(HtmlTextWriterStyle.BackgroundColor) = "Transparent"
                cell.Style(HtmlTextWriterStyle.FontSize) = "10pt"
                cell.Style(HtmlTextWriterStyle.Padding) = "2px"
                cell.Style(HtmlTextWriterStyle.FontFamily) = "Verdana"
                cell.Style(HtmlTextWriterStyle.Color) = "Blue"
                cell.Style(HtmlTextWriterStyle.Cursor) = "pointer"
                row.Cells.Add(cell)
            Next

            table.Attributes.Add("border", "0")
            table.Attributes.Add("cellspacing", "0")
            table.Attributes.Add("cellpadding", "0")
            table.Style("background-color") = "transparent"

            Content.Add(table)
        End Sub

#End Region
    End Class

    <RequiredScript(GetType(Obout.Ajax.UI.HTMLEditor.Popups.Popup))> _
    <System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Maintainability", "CA1501:AvoidExcessiveInheritance")> _
    Public Class SmallImageProperties
        Inherits Obout.Ajax.UI.HTMLEditor.Popups.ImageProperties
#Region "[ Properties ]"

        Protected Overrides ReadOnly Property Browse() As Obout.Ajax.UI.HTMLEditor.Popups.BrowseButton
            Get
                Return Nothing
            End Get
        End Property
        Protected Overrides ReadOnly Property ElementCSS() As TextBox
            Get
                Return Nothing
            End Get
        End Property
        Protected Overrides ReadOnly Property ElementID() As TextBox
            Get
                Return Nothing
            End Get
        End Property
        Protected Overrides ReadOnly Property AlternateText() As TextBox
            Get
                Return Nothing
            End Get
        End Property

#End Region
    End Class

    <RequiredScript(GetType(Obout.Ajax.UI.HTMLEditor.Popups.Popup))> _
    <System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Maintainability", "CA1501:AvoidExcessiveInheritance")> _
    Public Class SmallUrlProperties
        Inherits Obout.Ajax.UI.HTMLEditor.Popups.LinkProperties
#Region "[ Properties ]"

        Protected Overrides ReadOnly Property Browse() As Obout.Ajax.UI.HTMLEditor.Popups.BrowseButton
            Get
                Return Nothing
            End Get
        End Property
        Protected Overrides ReadOnly Property ElementCSS() As TextBox
            Get
                Return Nothing
            End Get
        End Property
        Protected Overrides ReadOnly Property ElementID() As TextBox
            Get
                Return Nothing
            End Get
        End Property
        Protected Overrides ReadOnly Property UrlTooltip() As TextBox
            Get
                Return Nothing
            End Get
        End Property
        Protected Overrides ReadOnly Property Target() As HtmlSelect
            Get
                Return Nothing
            End Get
        End Property

        Public Overrides Property DefaultTarget() As Obout.Ajax.UI.HTMLEditor.Popups.LinkTarget
            Get
                Return Obout.Ajax.UI.HTMLEditor.Popups.LinkTarget.[New]
            End Get
            Set(value As Obout.Ajax.UI.HTMLEditor.Popups.LinkTarget)
            End Set
        End Property

#End Region
    End Class
End Namespace
