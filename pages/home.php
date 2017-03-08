<!DOCTYPE html>
<head>
	<?php
		$data = mysql_query("SELECT COUNT(USER_ID) AS user_sum FROM user") 
		or die(mysql_error()); 
		$info = mysql_fetch_array( $data );
		$nmrUsers = $info['user_sum'];
		
		$data = mysql_query("SELECT COUNT(LINK_ID) AS user_sum FROM link") 
		or die(mysql_error()); 
		$info = mysql_fetch_array( $data );
		$nmrLinks = $info['user_sum'];
	?>
</head>
	
<body>
	<div id="enter">
		<h1> Welcome to SPIDERWEB</h1>
		<h3>&quot;  Your web of links and other spiderlings  &quot;</h3>
		<div class="banner" id="slower">
		</div>
		
		<div style="padding-top: 300px;">
			<h1>Introduction</h1>
			<p><span class="big">S</span>piderweb is a community for surfers to share favorite links, rate links and comment on friends links. 
			Join now and start sharing your links!
			</p>
			
			<h1>Site statistics</h1>
			<p><span class="big">T</span>he community currently has <?php echo $nmrUsers?> spiderlings and a web consisting of <?php echo $nmrLinks?> links
			</p>
		</div>
		
	</div>
<body>