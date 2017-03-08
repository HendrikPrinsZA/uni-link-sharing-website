<?php
	$con = mysql_connect("localhost","root","");
	if (!$con)
	{
		die ('Could not connect: ' . mysql_error());
	}
	mysql_select_db("dbmain", $con);
	
	if(!isset($_SESSION['userName']))
	{
		// session not logged in
		$userID = 0;
	} else
	{
		// session logged
		$userName = $_SESSION['userName'];
		
		$data = mysql_query("SELECT USER_ID FROM user WHERE (USER_USERNAME='$userName')") 
		or die(mysql_error()); 
		$info = mysql_fetch_array( $data );
		$userID = $info['USER_ID'];
	}
	
	
	if(!isset($_SESSION['linkOption']))
	{
		// session not logged in
		$option = 99;
	} else
	{
		// session logged 
		$option = $_SESSION['linkOption'];
	}
	
	if(isset($_POST['form']) && $_POST['form']=='true')
	{	
		if (isset($_POST['userID']) && $_POST['userID']!=0)
		{
			$name = $_POST["name"];
			$category = $_POST["categories"];
			$desc = $_POST["comment"];
			$linkURL = $_POST["linkURL"];
			
			$userID = $_POST['userID'];
			
			if ((strlen($name)<1) || (strlen($desc)<1) || (strlen($linkURL)<1))
			{
				echo "<h1>Input was incorrect</h1><br/>";
				echo "<h2>Click <a href='queries.php?number=2' target='container'>here</a> to try again</h2>";
			} else
			{
				// insertion to user table
				$sql = "INSERT INTO link(LINK_URL,LINK_DESC,LINK_CAT_ID,USER_ID,LINK_NAME) VALUES('$linkURL','$desc',$category,$userID,'$name')";
				if (!mysql_query($sql,$con))
				{
					//echo "<h1>Input was incorrect</h1><br/>";
					//echo "<h2>Click <a href='queries.php?number=2' target='container'>here</a> to try again</h2>";
					die;
					header("location: index.php?action=51");
					
				} else
				{
					$link_id = mysql_insert_id( $con );
					$sql = "INSERT INTO rating(RATING_ID, RATING_SCORE, RATING_TOTAL) VALUES ($link_id, 0, 0)";
					if (!mysql_query($sql,$con))
					{
						die;
						header("location: index.php?action=51");
					} else
					{
						header("location: ../index.php?action=50");
					}		
				}
			}
		}
	}
?>
<!DOCTYPE html>
<html>
    <head>
        <title> Account </title>
		<!--<script src="js/jquery-1.6.4.min.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript" src="js/link.js"></script>-->
		<link rel="stylesheet" href="css/postlink.css">
		<link rel="stylesheet" href="css/links.css">
		
    </head>
    <body>
		<div id="enter">
			<div id="main_menu">
				<ul id="menu">
					<li><a href="#"  name="links" id="links">View Links</a>
						<ul>
							<li><a href="index.php?action=2&linkOption=1">All links</a></li>
							<li><a href="index.php?action=2&linkOption=2">My links</a></li>
							<li><a href="index.php?action=2&linkOption=3">Top rated links</a></li>
						</ul>
					</li>
					<li><a href="#">Categories</a>
						<ul>
							<li><a href="#" target="container">My links</a></li>
							<?php
								$var1 = mysql_query("SELECT * FROM category") 
								or die(mysql_error());
								while($info = mysql_fetch_array( $var1 )) 
								{ 
									Print "<li><a";	
									//Click on link below to send friend request
									//alt="Go to Friends"
									Print " id=".$info['CAT_ID']." title='".$info['CAT_Description']."' href='#'>".$info['CAT_NAME']."</a>"; 
									Print "</li>";
								} 	
							?>
						</ul>
					</li>
					<?php 
						if ($userID>0) 
							echo "	<li><a href='index.php?action=3'  name='nlinks' id='links'>Add new link</a>
									</li>"
					?>
				</ul>
			</div>
		
			<div>
				<br/><br/>
				<?php
					echo "	<div id='stylized' class='myform'></br></br>
							<form id='theform' name='theform' method='post' action='pages/postlink.php'><br/>
								<h1>Post a new link</h1><br/>
								<p>Feel free to post a link you might find interesting</p><br/></br>

								<label>Link Name<br/>
								<span class='small'>Add your name</span><br/>
								</label><br/>
								<input type='text' name='name' id='name' required/><br/></br>

								<label>Link Category<br/>
								<span class='small'>Add category</span><br/>
								</label><br/><br/>
								<select name='categories'>
								";
								$var1 = mysql_query("SELECT * FROM category") 
								or die(mysql_error());
								while($info = mysql_fetch_array( $var1 )) 
								{ 
									Print "<option";	
									//Click on link below to send friend request
									//alt="Go to Friends"
									Print " value=".$info['CAT_ID']." title='".$info['CAT_Description']."'>".$info['CAT_NAME']."</td>"; 
									Print "</option>";
								} 		
			echo				"</select><br/></br>
								
								<label>Link Description<br/>
								<span class='small'>Add a valid address</span><br/>
								</label><br/>
									<textarea name='comment' id='comment' required></textarea><br />
								<br/></br>

								<label>Link URL<br/>
								<span class='small'>Add a valid address</span><br/>
								</label><br/>
								<input type='url' name='linkURL' id='linkURL' required/><br/></br>

								<input type='hidden' value=$userID id='userID' name='userID'/>
								<input name='form' type='hidden' id='form' value='true'>
								<input type='submit' value='Post link'/><br/>
								<div class='spacer'></div><br/></br>
							</form><br/>
						</div></br>";
				?>
			</div>
		</div>
	</body>
</html>