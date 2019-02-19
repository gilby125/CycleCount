Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.IO
Imports System.Web.UI.WebControls
Imports Obout.Ajax.UI.FileUpload

Partial Public Class FileUpload_vb_WithoutPostback
    Inherits System.Web.UI.Page
    Implements System.Web.UI.ICallbackEventHandler
    Public sCallBackFunctionInvocation As String

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        If Not Page.IsPostBack Then
            Dim imageN As String = Page.Request.QueryString("getimage")
            ' if used as Image's SRC
            If Not [String].IsNullOrEmpty(imageN) Then
                If Session("image_" & imageN) IsNot Nothing Then
                    Page.Response.ContentType = "image/gif"
                    Page.Response.BinaryWrite(DirectCast(Session("image_" & imageN), Byte()))
                    Page.Response.[End]()
                End If
            End If
        End If
        sCallBackFunctionInvocation = Page.ClientScript.GetCallbackEventReference(Me, "action", "processMyResult", "context", "processMyError", False)
    End Sub

    Private returnstring As String

    Private Function ICallbackEventHandler_GetCallbackResult() As String Implements ICallbackEventHandler.GetCallbackResult
        Return returnstring
    End Function

    Private Sub ICallbackEventHandler_RaiseCallbackEvent(eventArgument As String) Implements ICallbackEventHandler.RaiseCallbackEvent
        If eventArgument = "saveUploadedFiles" Then
            ' here you can save the uploaded files using 'fileUpload1.PostedFiles'
            '-----------------------------------------------------------
            Dim images As String = ""
            Dim totalSize As Long = 0
            Dim imageN As Integer = 0
            For Each info As PostedFileInfo In fileUpload1.PostedFiles
                Session("image_" & imageN) = getImage(info.InputStream)
                Dim url As String = Page.Request.Path
                url += (If((url.IndexOf("?") > 0), "&", "?")) & "getimage=" & imageN.ToString() & "&rnd=" & (New Random().[Next]().ToString())
                images += (If(imageN > 0, "&nbsp;", "")) & "<img alt='' src='" & url & "'>"
                totalSize += info.ContentLength
                imageN += 1
            Next
            returnstring = "Uploaded " & fileUpload1.PostedFiles.Count.ToString() & " file" & (If(imageN > 1, "s", "")) & ", total size: " & totalSize.ToString() & "<br /><br />" & images
        End If
    End Sub

    ' get Thumbnail of uploaded image
    Private Function getImage(imageStream As Stream) As Byte()
        Dim maxWidth As Integer = 100
        Dim maxHeight As Integer = 100
        Dim buf As Byte() = Nothing

        imageStream.Position = 0
        Dim objImage As System.Drawing.Image = System.Drawing.Image.FromStream(imageStream)

        Dim imageStreamN As MemoryStream
        Dim View As System.Drawing.Image
        Dim myCallback As New System.Drawing.Image.GetThumbnailImageAbort(AddressOf ThumbnailCallback)

        Dim mWidth As Integer = objImage.Width
        Dim mHeight As Integer = objImage.Height

        If mWidth > maxWidth Then
            mHeight = CInt(Math.Truncate(CDbl(mHeight) * (CDbl(maxWidth) / CDbl(mWidth))))
            mWidth = maxWidth
        End If
        If mHeight > maxHeight Then
            mWidth = CInt(Math.Truncate(CDbl(mWidth) * (CDbl(maxHeight) / CDbl(mHeight))))
            mHeight = maxHeight
        End If

        If mHeight = 0 Then
            mHeight = 5
        End If
        If mWidth = 0 Then
            mWidth = 5
        End If

        View = objImage.GetThumbnailImage(mWidth, mHeight, myCallback, IntPtr.Zero)
        imageStream.Close()
        imageStreamN = New MemoryStream()
        imageStreamN.Position = 0
        View.Save(imageStreamN, objImage.RawFormat)
        View.Dispose()
        objImage.Dispose()
        imageStreamN.Position = 0
        buf = New Byte(CInt(imageStreamN.Length) - 1) {}
        imageStreamN.Read(buf, 0, CInt(imageStreamN.Length))
        imageStreamN.Close()
        Return buf
    End Function

    Private Function ThumbnailCallback() As Boolean
        Return False
    End Function
End Class
