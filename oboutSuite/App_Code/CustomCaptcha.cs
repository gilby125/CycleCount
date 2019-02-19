using Obout.Ajax.UI.Captcha;

namespace CustomCaptcha
{
    /// <summary>
    /// Summary description for CustomCaptcha
    /// </summary>
    public class MyCaptchaImage : CaptchaImage
    {
        protected override void Render(System.Web.UI.HtmlTextWriter writer)
        {
            base.Render(writer);
            if (Page.IsPostBack)
            {
                writer.Write("<script>document.getElementById('" + this.CurrentGuidId + "').value = '"+this.CurrentGuid+"';</script>");
            }
        }
    }
}