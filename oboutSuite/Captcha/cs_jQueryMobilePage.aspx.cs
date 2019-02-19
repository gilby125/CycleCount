using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Captcha_cs_jQueryMobilePage : System.Web.UI.Page
{
    protected void btnConnectClick(object sender, EventArgs e)
    {
        reqCaptcha.Validate();
        if (!reqCaptcha.IsValid)
        {
            return;
        }

        custCaptcha.Validate();
        if (!custCaptcha.IsValid)
        {
            return;
        }

        trCaptcha.Visible = false;
        trLogged.Visible = true;
    }
}