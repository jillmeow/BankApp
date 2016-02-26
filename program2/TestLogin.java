/*
 File: TestLogin.java
 September 2015
*/

import java.io.*;
import java.util.*;
import java.sql.*;

/**
 * This program can view and manage customer's account
 *
 * @author Jill Mirandilla
 */

public class TestLogin {
    private List<String> allBank = new ArrayList<String>();
    private List<String> allIRDnum = new ArrayList<String>();

    public static void main (String[] args) {
	new TestLogin().go();
    }
  
    // This is the function that does all the work
    private void go() {
    
	// Read pass.dat
	UserPass login = new UserPass();
	String user = login.getUserName();
	String pass = login.getPassWord();
	String host = "silver";
    
	Connection con = null;
	try {
	    // Register the driver and connect to Oracle
      DriverManager.registerDriver 
	  (new oracle.jdbc.driver.OracleDriver());
      String url = "jdbc:oracle:thin:@" + host + ":1527:cosc344";
      System.out.println("url: " + url);
      con = DriverManager.getConnection(url, user, pass);
      Statement query = con.createStatement();
      //getBankUsage(query);
      //getBank(query);
      //System.out.println(allBank);
      //getUserBalance(query, "77321234");
      //getBalanceFromBank(query, "'ANZ'", "82342342");
      //int newBalance = getBalanceFromAccount(query, "34594500") + 50;
      //updateBalance(query, "77321234", newBalance, "34594500");
      //System.out.println(getBalanceFromAccount(query, "34594500"));
      //System.out.println(getBalanceFromAccount(query, "77321234"));
      //double total = getTotalBalanceAccount(query, "'77321234'");
      //setTotalBalance(query, total, "77321234");
      System.out.println("Welcome to Banking App");
      System.out.println("Press 1 to view your account"); 
      System.out.println("Press 2 to view bank usage");
      System.out.println("Press 3 to view your total balance");
      System.out.println("Press 4 to quit the App");
      boolean terminator = false;
      while(terminator != true) {
	  Scanner input = new Scanner(System.in);
          int command = input.nextInt();
	  if(command == 1){
	      System.out.println("You have chosen to view your account as a customer");
	      getBank(query);
	      System.out.println("Select which bank do you want to view");
	      System.out.println(allBank);
	      Scanner iBank = new Scanner(System.in);
	      String bank = iBank.nextLine();
	      viewAccount(bank);
	      allBank.clear();
	  } else if(command == 2){
	      getBankUsage(query);
	  } else if(command == 3){
	      System.out.println("Please enter your IRD Numer: "); 
	      Scanner inputIRD = new Scanner(System.in);
	      String irdNumber = inputIRD.nextLine();
	      
		  irdNumber = "'" + irdNumber + "'";
		  getUserBalance(query, irdNumber);
	  } else if(command == 4){
	      terminator = true;
	      System.out.println("Thank you for using Banking App.");

	  } else {
	      System.out.println("You have entered an invalid command. Please try again");
	  }

      }

	} catch (SQLException e) {
	    System.out.println(e.getMessage());
	    System.exit(1);
      
	} finally {
	    if (con != null) {
		try {
		    con.close();
		} catch (SQLException e) {
		    quit(e.getMessage());
		}
	    }
	}
    }
    // end go()

    public void viewAccount(String bName) throws SQLException{
	boolean terminate = false;
	while(terminate != true){
	    if(bName.equals(allBank.get(0))){
		atm(bName);
		terminate = true;
	    } else if(bName.equals(allBank.get(1))){
		atm(bName);
		terminate = true;
	    } else if(bName.equals(allBank.get(2))){
	        atm(bName);
		terminate = true;
	    } else if(bName.equals(allBank.get(3))){
		atm(bName);
		terminate = true;
	    } else if(bName.equals(allBank.get(4))){
		atm(bName);
		terminate = true;
	    } else { 
		System.out.println("That bank doesn't exist.");
		System.out.println("Press 1 to try again or press 4 to exit");
		terminate = true;
	    }
	}

    }
    public void atm(String bank) throws SQLException{
	UserPass login = new UserPass();
	String user = login.getUserName();
	String pass = login.getPassWord();
	String host = "silver";
	Connection con = null;
	try {
	    DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
	    String url = "jdbc:oracle:thin:@" + host + ":1527:cosc344";
	    con = DriverManager.getConnection(url, user, pass);
	    Statement query = con.createStatement();
	System.out.println("Hello and welcome to " + bank);
	System.out.println("Please enter your IRD number to login: ");
	Scanner input = new Scanner(System.in);
	String irdNum = input.nextLine();
	irdNum = "'"+irdNum + "'";
	String bankName = "'"+ bank + "'";
	getBalanceFromBank(query,bankName, irdNum);
	System.out.println("Press 5 to withdraw on your account");
	System.out.println("Press 6 to deposit on your account");
	System.out.println("Press 0 to logout on your account");
	Scanner actionInput = new Scanner(System.in);
	int action = actionInput.nextInt();
	if(action == 5){
	    System.out.println("Please enter your account number: ");
	    Scanner acctInput = new Scanner(System.in);
	    String acctNo = "'"+acctInput.nextLine()+"'";
	    System.out.println("Your balance for this account is: $" + getBalanceFromAccount(query, acctNo));
	    System.out.println("Please enter the amount that you wish to withdraw: ");
	    Scanner moneyInput = new Scanner(System.in);
	    double money = (double) moneyInput.nextDouble();
	    double newBalance = getBalanceFromAccount(query, acctNo) - money;
	    updateBalance(query, irdNum, newBalance, acctNo);
	    double total = getTotalBalanceAccount(query, irdNum);
	    setTotalBalance(query, total, irdNum);
	    System.out.println("Your new balance for this account is now: $"
			       + getBalanceFromAccount(query, acctNo));
	    System.out.println("Thank you for using " + bank);
	} else if(action == 6){
            System.out.println("Please enter your account number: ");
            Scanner acctInput = new Scanner(System.in);
            String acctNo = acctInput.nextLine();
	    System.out.println("Your balance for this account is: $" + getBalanceFromAccount(query, acctNo));
            System.out.println("Please enter the amount that you wish to deposit: ");
            Scanner moneyInput = new Scanner(System.in);
            double money = (double) moneyInput.nextDouble();
            double newBalance = getBalanceFromAccount(query, acctNo) + money;
            updateBalance(query, irdNum, newBalance, acctNo);
            double total = getTotalBalanceAccount(query, irdNum);
            setTotalBalance(query, total, irdNum);
            System.out.println("Your new balance for this account is now: $"
                               + getBalanceFromAccount(query, acctNo));
            System.out.println("Thank you for using " + bank);
	} else if(action == 0){
	    System.out.println("Thank you for using " + bank);
	} else {
	    System.out.println("Invalid command. Please try again.");
	}
	System.out.println("Press 1 to have another transaction or press 4 to exit the App");
	
	} catch (SQLException e){
	    System.out.println(e.getMessage());
	    System.exit(1);
	} finally {
	    if(con != null){
		try {
		    con.close();
		} catch (SQLException e){
		    quit(e.getMessage());
		}
	    }
	}
    }

    public void depositBalance(){


    }

    public void withdrawBalance(){


    }
  
  
  
    /**
   Gets all the bank and number of customer signed up on their bank.
    */
    private void getBankUsage(Statement query) throws SQLException {
	String sql = new String( "SELECT B.NAME, COUNT(Distinct(C.IRD)) FROM CUSTOMER C, ACCOUNT_CUSTOMER AC, BANK B, ACCOUNT A WHERE AC.IRDNUM = C.IRD AND A.BCODE = B.ROUTINGCODE AND AC.ANUM = A.ACCTNO GROUP BY B.NAME order by b.name asc");
	ResultSet rset = query.executeQuery(sql);
	while(rset.next()){
	    System.out.println("Bank: " + rset.getString(1) + " No. of Customers: " + rset.getString(2));
	}
    }
    /**
   Gets the total balance of the customer's account for overall bank
    */
    private void getUserBalance(Statement query, String irdNo) throws SQLException {
	String sql = new String("select name, totalbalance from customer where ird = " + irdNo);
	ResultSet rset = query.executeQuery(sql);
	while(rset.next()){
	    System.out.println("Hi " + rset.getString(1));
	    System.out.println("Your total balance is: $" + rset.getString(2));
	}
    }
  
    /**
   sets the total balance of the customer as soon as they updated their account
    */
    private void setTotalBalance(Statement q, double total, String ird) throws SQLException{
	String sql = "UPDATE customer set totalbalance = " + total + " where ird= " + ird;
	int rowsUpdated = q.executeUpdate(sql);
    }
    /**
   This will calculate the total balance that the customer had in their account
    */
    private double getTotalBalanceAccount(Statement query, String irdNo) throws SQLException{
	String sql = new String("select balance from account, account_customer  where anum = acctno and irdNum=" + irdNo);
    
	ResultSet rset = query.executeQuery(sql);
	double totalBalance = 0;
	while(rset.next()){
	    totalBalance = totalBalance + rset.getDouble(1);
	}
	return totalBalance;
    }
  
    /*Gets the remaining balance on your bank account */
    private double getBalanceFromAccount(Statement query, String acctNo) throws SQLException{
	String sql = new String("select balance from account a where a.acctNo = " + acctNo);
	ResultSet rset = query.executeQuery(sql);
	double balance = 0;
	while(rset.next()){
	    balance = rset.getDouble(1);
	}
    
	return balance;
    
    }
  
    /**
   Updates your account balance on your bank account
    */
    private void updateBalance(Statement query, String irdNo, double balance, String acctNo) throws SQLException{
	String command = "update account set balance = " + balance + "where acctNo = " + acctNo;
	int rowsUpdated = query.executeUpdate(command);
	
    
    }
  
    /* Gets all the available bank */
    private void getBank(Statement query) throws SQLException{
	String sql = new String("select name from bank");
	ResultSet rset = query.executeQuery(sql);
	while(rset.next()){
	    allBank.add(rset.getString(1));
	}
    }
    /**
   Gets your account from a certain bank
    */
    private void getBalanceFromBank(Statement query, String bankName, String irdNum) throws SQLException{
	String sql = new String("select b.name, acctno, balance, c.name, type from account, bank b, account_customer, customer c where bcode = routingcode and ird=IRDnum and aNum = acctNo and ird = " + irdNum + " and b.name = " + bankName);
	ResultSet rset = query.executeQuery(sql);
	double totalBalance = 0;
	//System.out.println("Hi there, " + rset.getString(4));
	while(rset.next()){
	    System.out.println("Your " + rset.getString(5) 
			       + " account - "+ rset.getString(2) 
			       + " is: $"+ rset.getString(3));
	    //System.out.println(rset.getString(2) + "    " + rset.getString(3));
	    totalBalance = totalBalance + rset.getDouble(3);
	}
	System.out.println("----------------------------------------------------");
	System.out.println("Total balance of: $" + totalBalance);
    }
  
  
  
    // Used to output an error message and exit
    private void quit(String message) {
	System.err.println(message);
	System.exit(1);
    }
  
} // end class TestLogin