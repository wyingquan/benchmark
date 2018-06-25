-- query95
SELECT  
        Count(DISTINCT  ws1.ws_order_number) AS order_count, 
        Sum(ws1.ws_ext_ship_cost)           AS total_shipping_cost, 
        Sum(ws1.ws_net_profit)              AS total_net_profit   
FROM   web_sales ws1, 
      web_sales ws2,
     date_dim , 
     customer_address , 
     web_site 
WHERE  ws1.ws_order_number = ws2.ws_order_number 
AND    ws1.ws_warehouse_sk <> ws2.ws_warehouse_sk
AND Cast(d_date AS DATE) BETWEEN Cast('2000-4-01' AS DATE) AND      ( 
                  Cast('2000-6-01' AS DATE)) 
AND      ws1.ws_ship_date_sk = d_date_sk 
AND      ws1.ws_ship_addr_sk = ca_address_sk 
AND      ca_state = 'IN' 
AND      ws1.ws_web_site_sk = web_site_sk 
AND      web_company_name = 'pri' 
AND      ws1.ws_order_number IN 
         ( 
                SELECT ws_order_number 
                FROM   ( 
       SELECT ws1.ws_order_number, 
              ws1.ws_warehouse_sk wh1, 
              ws2.ws_warehouse_sk wh2 
       FROM   tpcds2.web_sales ws1, 
              tpcds2.web_sales ws2 
       WHERE  ws1.ws_order_number = ws2.ws_order_number 
       AND    ws1.ws_warehouse_sk <> ws2.ws_warehouse_sk) ) 

LIMIT 100; 