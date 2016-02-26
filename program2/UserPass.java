/*
  File:  UserPass.java
  July 2002
*/

import java.io.*;
import java.util.*;
import java.lang.*;

/**
 * Reads a username and password from a file called pass.dat.
 *
 * @author Paul Werstein
 */

public class UserPass {

    private String password;
    private String username;

    // Constructor - Also reads the username and password
    //               from the file.
    public UserPass () {
	String line = null;
	String passwordFile = "pass.dat";
	try {
	    BufferedReader inFile = 
		new BufferedReader(new FileReader(passwordFile));
	    // Read the username from the file and store it.
	    if ((line = inFile.readLine()) == null) {
		quit(passwordFile + " is empty");
	    }
	    StringTokenizer tok = new StringTokenizer(line);
	    if (tok.countTokens() != 1) {
		quit("Username line has an error");
	    }
	    username = tok.nextToken();
	    // Read the password from the file and store it.
	    if ((line = inFile.readLine()) == null) {
		quit(passwordFile + " has a bad format");
	    }
	    tok = new StringTokenizer(line);
	    if (tok.countTokens() != 1) {
		quit("Password line has an error");
	    }
	    password = tok.nextToken();
	} catch (FileNotFoundException e) {
	    quit("The file, " + passwordFile + ", was not found.");
	} catch (IOException e) {
	    quit("An error occured trying to read " + passwordFile);
	}
    }

    // Returns the password

    public String getPassWord() {
	return password;
    }

    // Returns the username

    public String getUserName() {
	return username;
    }

    // Used for printing reasons for exceptions or errors.

    private void quit(String message) {
	System.err.println(message);
	System.exit(1);
    }

} // end class UserPass
