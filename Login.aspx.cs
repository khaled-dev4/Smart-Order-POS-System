using System;

namespace WebApplication8
{
    public partial class Login : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // دخول مباشر وبسيط ومفهوم للمقابلة بدون تعقيد داتابيز حالياً
            if (txtUser.Text == "admin" && txtPass.Text == "123")
            {
                // أول ما يدخل صح، السيستم يرميه فوراً على شاشة عمل الطلبات
                Response.Redirect("CreateOrder.aspx");
            }
            else
            {
                lblError.Text = "Invalid Username or Password!";
            }
        }
    }
}