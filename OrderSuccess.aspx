<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderSuccess.aspx.cs" Inherits="WebApplication8.OrderSuccess" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <title>Order Confirmed & Receipt</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f6f9; font-family: 'Segoe UI', sans-serif; }
        .receipt-card { max-width: 500px; margin: 40px auto; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.08); background-color: #ffffff; }
        @media print {
            .no-print { display: none !important; }
            body { background-color: #fff; }
            .receipt-card { box-shadow: none; margin: 0; max-width: 100%; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="receipt-card p-4">
                
                <!-- الجزء الخاص بالنجاح والطباعة -->
                <div class="text-center mb-4">
                    <h2 class="text-success fw-bold">✔ Order Confirmed</h2>
                    <p class="text-muted">Order ID: <asp:Label ID="lblOrderId" runat="server" Font-Bold="true"></asp:Label></p>
                </div>

                <hr />

                <!-- تفاصيل الفاتورة لايف للمستهلك -->
                <div class="mb-4">
                    <h5 class="fw-bold mb-3">Receipt Details:</h5>
                    <asp:GridView ID="gvReceiptDetails" runat="server" CssClass="table table-borderless table-sm align-middle" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="ProductName" HeaderText="Item" ItemStyle-HorizontalAlign="Left" />
                            <asp:BoundField DataField="Quantity" HeaderText="Qty" ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="Total" HeaderText="Total (EGP)" DataFormatString="{0:N2}" ItemStyle-HorizontalAlign="Right" />
                        </Columns>
                    </asp:GridView>
                </div>

                <div class="d-flex justify-content-between align-items-center border-top pt-3 mb-4">
                    <span class="fs-4 fw-bold">Grand Total:</span>
                    <span class="fs-4 fw-bold text-success"><asp:Label ID="lblTotalAmount" runat="server"></asp:Label> EGP</span>
                </div>

                <!-- لوحة أزرار التحكم (تختفي أوتوماتيك أثناء طباعة الورقة) -->
                <div class="d-grid gap-2 no-print">
                    <button type="button" class="btn btn-dark py-2 fw-bold" onclick="window.print();">🖨 Print Invoice</button>
                    <a href="CreateOrder.aspx" class="btn btn-primary py-2 fw-bold">🔄 Go to Main Menu (New Order)</a>
                </div>

            </div>
        </div>
    </form>
</body>
</html>