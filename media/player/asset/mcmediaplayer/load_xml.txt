<?php

/*************************************************************
  This file will allow you to specify a directory of your 
  media files and will dynamically generate an XML file of all 
  the files in the specifyed directory/sub direcories. 
  This file can be read by MC Media Player. The script will 
  only output mp3 and flv files, all others will
  be ignored. 

  Note: The folder which contains the XML file will neeed
        write privlages. 

  Note: edit line 121 to look in the your specific media 
	folder

 Created by: Paul Needleman, paul.needleman@gmail.com


************************************************************/


        //deletes the .xml file 
	$fh = fopen('mcmp720x360_playlist.xml', 'w');
	$myString = " ";
	fwrite($fh,$myString);	
	fclose($fh);


function getDirectory( $path = '.', $level = 0 ){
     
     	
     $fh=fopen('mcmp720x360_playlist.xml',"a");
     //opens .xml file for writing   

    $ignore = array( 'cgi-bin', '.', '..' );
    // Directories to ignore when listing output. Many hosts
    // will deny PHP access to the cgi-bin.

    $dh = @opendir( $path );
    // Open the directory to the handle $dh


  
    
    while( false !== ( $file = readdir( $dh ) ) ){
    // Loop through the directory
    
        if( !in_array( $file, $ignore ) ){
        // Check that this file is not to be ignored
            
            $spaces = str_repeat( '&nbsp;', ( $level * 4 ) );
            // Just to add spacing to the list, to better
            // show the directory tree.
            
            if( is_dir( "$path/$file" ) ){
            // Its a directory, so we need to keep reading down...
            	
	
               // echo "<strong>$spaces $file</strong><br />";
		
		$new_folder = $new_file = str_replace("'", "%27", $folder);
		//changes "'" to %27 so it can be interpreted by HTML in URL

		echo "<~folder label=\"$quote$file\"$quote><br />";
	        $myString1  = "<folder label=\"$quote$file\"$quote>\n";
		fwrite($fh,$myString1);
		//displays and outputs folder structure to xml file. Note: the HTML output will 
                // put a ~ in html tags ie <~file> so they will display on the screen.

	       	getDirectory( "$path/$file", ($level+1) );
                // Re-call this same function but on a new directory.
                // this is what makes function recursive.
		echo "<~/folder><br /><br />";
		$myString2 = "</folder>\n\n";
		fwrite($fh,$myString2);
		//writes closing folder tag
 		
            } else {
            
                //echo "$spaces $file<br />";
                // Just print out the filename
		
		
		if (substr($file, -3, 3) == "mp3" or substr($file, -3, 3) == "flv") //we only want mp3 files and not m3u and jpg
		{        
			
			$new_file = str_replace("'", "%27", $file);
 			//changes "'" to %27 so it can be interpreted by HTML in URL

			echo "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<~file label=\"$quote$file\"$quote url=\"$quote$path/$file\"$quote> <~file><br />";
			//displays output to screen  Note: the HTML output will put a ~ in html tags ie <~file> so they will display on the screen.
			
			$myString3 = "     <file label=\"$quote$file\"$quote url=\"$quote$path/$new_file\"$quote></file>\n";
			fwrite($fh,$myString3);
			//writes to XML file
			
            	}

            }
        
        }
    }     
	  
    closedir( $dh );
    // Close the directory handle

    	//close($fh);	
    	//close file writing


}
 
$fh=fopen('mcmp720x360_playlist.xml',"a");   
$myString = "<playlist>\n";
fwrite($fh,$myString);
echo "<~playlist>\n\n\n";
//writes the <playlist> tag to the beginning of the file


/****EDIT THIS LINE TO YOUR MEDIA DIRECTORY****/
 echo getDirectory( "files" );
// Get contents of the "files/includes" folder  



$myString = "</playlist>";
fwrite($fh,$myString);
fclose($fh);
echo "<~/playlist>";
//writes the </playlist> tag to the end of the file
?> 
