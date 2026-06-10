using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication8
{
    public partial class ManageProductsEn : System.Web.UI.Page
    {
        private string connString = "Data Source=.;Initial Catalog=SmartOrderDB;Integrated Security=True;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindProductsGrid();
            }
        }

        protected void btnSaveProduct_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string productName = txtProductName.Text.Trim();
            decimal price = 0;

            if (!decimal.TryParse(txtProductPrice.Text.Trim(), out price) || price <= 0)
            {
                lblStatus.Text = "❌ Invalid Price! Must be a positive number.";
                lblStatus.ForeColor = System.Drawing.Color.Red;
                return;
            }

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                string checkQuery = "SELECT COUNT(1) FROM Products WHERE ProductName = @Name";
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@Name", productName);
                    int exists = Convert.ToInt32(checkCmd.ExecuteScalar());

                    if (exists > 0)
                    {
                        lblStatus.Text = "❌ This product already exists in the menu!";
                        lblStatus.ForeColor = System.Drawing.Color.Red;
                        return;
                    }
                }

                string insertQuery = "INSERT INTO Products (ProductName, Price) VALUES (@Name, @Price)";
                using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@Name", productName);
                    cmd.Parameters.AddWithValue("@Price", price);

                    try
                    {
                        cmd.ExecuteNonQuery();

                        lblStatus.Text = "✅ " + productName + " added successfully!";
                        lblStatus.ForeColor = System.Drawing.Color.Green;

                        txtProductName.Text = "";
                        txtProductPrice.Text = "";
                    }
                    catch (Exception ex)
                    {
                        lblStatus.Text = "❌ Error: " + ex.Message;
                        lblStatus.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }

            BindProductsGrid();
        }

        protected void btnDeleteProduct_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int productId = Convert.ToInt32(btn.CommandArgument);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string deleteQuery = "DELETE FROM Products WHERE ProductID = @ID";
                using (SqlCommand cmd = new SqlCommand(deleteQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@ID", productId);

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();

                        lblStatus.Text = "✅ Item deleted from menu successfully!";
                        lblStatus.ForeColor = System.Drawing.Color.Green;
                    }
                    catch (SqlException ex)
                    {
                        if (ex.Number == 547)
                        {
                            lblStatus.Text = "❌ Cannot delete this item because it is linked to past orders history!";
                            lblStatus.ForeColor = System.Drawing.Color.OrangeRed;
                        }
                        else
                        {
                            lblStatus.Text = "❌ Error: " + ex.Message;
                            lblStatus.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                }
            }

            BindProductsGrid();
        }

        public void BindProductsGrid()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT ProductID, ProductName, Price FROM Products ORDER BY ProductID DESC";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        gvProducts.DataSource = dt;
                        gvProducts.DataBind();
                    }
                }
            }
        }


        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}