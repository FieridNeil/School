<?php
    require_once("../src/config.php");
    

   session_start();
 
   $sessionID = session_id();
   $request_uri = explode('?', $_SERVER['REQUEST_URI'], 2);

      
        
      $sql = "SELECT * FROM SESSION WHERE session_id='{$sessionID}'";
      $result = $conn->query($sql);
      if (!$result) {
        echo $sql . "Query failed" . $conn->error . PHP_EOL;
      } else {
        
        if(isset($_SESSION['username'])){
            // Real account
            
            // Get user id
            $sql = "SELECT * FROM account WHERE username = '{$_SESSION['username']}'";
            $result = $conn->query($sql);
            if(!$result){
            echo "Fail to execute: " . $sql . $conn->error . "<br />";
            }else{
                $user_account = $result->fetch_assoc();  
                $_SESSION['id'] = $user_account['id']; // User id
            }
            
            // Check to see if they have anything saved from their cart
            $sql = "SELECT * FROM cart INNER JOIN session WHERE session.session_id = cart.session_id AND session.account_id = {$_SESSION['id']} and cart.purchased = 0";
            $join_result = $conn->query($sql);            
            if (!$join_result) {
                echo $sql . "Query failed" . $conn->error . PHP_EOL;
            }else{
                //echo $result->num_rows;
                while($row = $join_result->fetch_assoc()){
                    if($row['session_id'] != $sessionID){
                        $sql = "UPDATE cart SET session_id = '{$sessionID}' WHERE session_id = '{$row['session_id']}'";
                        $result = $conn->query($sql);
                        if(!$result){
                            echo $sql . "Query failed" . $conn->error . PHP_EOL;
                        }
                    }
                }
            }
            
            $sql = "SELECT * FROM session WHERE account_id = {$_SESSION['id']}";
            $result1 = $conn->query($sql);
            if (!$result1) {
                echo $sql . "Query failed" . $conn->error . PHP_EOL;
            }else{
                while($row = $result1->fetch_assoc()){
                    if($row['session_id'] != $sessionID){
                        $sql = "DELETE FROM session WHERE session_id =  '{$row['session_id']}'";
                        $result = $conn->query($sql);
                        if (!$result) {
                            echo $sql . "Query failed" . $conn->error . PHP_EOL;
                        }
                    }
                }
                
            }
            
        }else{
                $_SESSION['id'] = 1; // Guest id
        }
        
       
        
        $sql = "INSERT INTO SESSION (session_id, account_id) VALUES ('{$sessionID}', {$_SESSION['id']}) ON DUPLICATE KEY UPDATE account_id = {$_SESSION['id']}";
        $result = $conn->query($sql);
        if (!$result) {
          echo $sql . "Query failed" . $conn->error . PHP_EOL;
        }
      }
       

    switch ($request_uri[0]) {
      case '/': //home page
        require '../src/home.php';
        break;
      case '/getProducts': // get json of products
        require '../src/getProducts.php';
        break;
      case '/getCart': // get json of customer cart
        require '../src/getCart.php';
        break;
      case '/postCart': // post update customer's cart
        require '../src/postCart.php';
        break;
      case '/product': // page of individual product
        require '../src/product.php';
        break;
      case '/cart': // page for cart
        require '../src/cart.php';
        break;
      case '/about': // page for about
        require 'view/about.phtml';
        break;
      case '/checkout': // page for checkout
        require '../src/checkout.php';
        break;
      case '/submitOrder': // order placed
        require '../src/processOrder.php';
        break;
      case '/account':
        require 'view/loginSignup.phtml';
        break;
        
      case '/login':
        require '../src/login.php';
        break;
        
      case '/register':
        require '../src/register.php';
        break; 
        
      case '/logout':
        require '../src/logout.php';
        break;
        
      case '/account_setting':
        require 'view/account_setting.phtml';
        break;
        
      case '/update_account':
        require '../src/update_account.php';
        break;
        
      case '/transaction_history':
        require '../src/transaction_hist.php';
        break;
        
      case '/processReview':
        require '../src/processReview.php';
        break;
                
      default:
        require 'view/404.phtml';
        break;
        
        
    }
?>
