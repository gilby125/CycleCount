
Partial Class Captcha_vb_jQueryMobilePage
    Inherits System.Web.UI.Page
    Protected Sub btnConnectClick(sender As Object, e As EventArgs)
        reqCaptcha.Validate()
        If Not reqCaptcha.IsValid Then
            Return
        End If

        custCaptcha.Validate()
        If Not custCaptcha.IsValid Then
            Return
        End If

        trCaptcha.Visible = False
        trLogged.Visible = True
    End Sub
End Class
