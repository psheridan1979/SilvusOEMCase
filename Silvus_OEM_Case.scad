tolerance = 0.6;
space_x = 105;
space_y = 115;
space_z = 45;
board_x = 92;
board_y = 55;
board_z = 20;
heatsink_y = 70;
heatsink_x = 70;

//bottom_heat_sink_z = ;//tbd
//figure out whether to to trim power/data port board for height
//pow_data_port_z = 36.1 + tolerance;
pow_data_port_radius = 8;
pow_data_port_separation = 25.5; //zero tolerance
led_radius = 3.5;
antenna_radius = 3.5;
antenna_separation = 92.9;
antenna_x_offset = 25;

anchor_screw_radius = 1.6;
anchor_screw_x_offset = 30;

screw_radius = 1;  //tbd but 0.5 looks reasonable 
screw_length = 10; //tbd but 10 looks reasonable
screw_head_radius = 1; //tbd 
ziptie_width = 4.0; //tbd but 4 looks reasonable
wall_thickness = 2.0;

screw_separation_x = 80;
screw_separation_y = 105;

leg_x = 25;
leg_y = 15;
leg_z = wall_thickness;

box_x = space_x;
box_y = space_y;
box_z = space_z;

//box
///*
union()
{
	difference()
	{
		cube([box_x,box_y,box_z], center = true);
		cube([box_x-wall_thickness*2,box_y-wall_thickness*2,box_z-wall_thickness*2], center = true); 
		translate([0,0,-(box_z-wall_thickness)/2]) cube([box_x+1,box_y+1,wall_thickness+1],center = true);
		//openings for power/data ports
		for (y_offset = [0:1])
		{
			mirror([0,y_offset,0])
			translate([-box_x/2,pow_data_port_separation/2,space_z/6]) rotate([0,90,0]) cylinder(h=4*wall_thickness, r    = pow_data_port_radius, $fn=20, center = true);
		}
		//opening for led indicator
		translate([-box_x/2,0,-space_z/8]) rotate([0,90,0]) cylinder(h=4*wall_thickness, r = led_radius, $fn=20, center = true);
		//opening for antennae
		for (y_offset = [0:1])
		{
		 mirror([0,y_offset,0])
		translate([-antenna_x_offset,box_y/2,space_z/6]) rotate([0,90,90]) cylinder(h=4*wall_thickness, r = antenna_radius, $fn=100, center = true);
		}
		//box mounting screw holes
		translate([anchor_screw_x_offset,0,0])
		{
			for(x_offset = [0:1]){for(y_offset = [0:1]){
				mirror([x_offset,0,0]){ mirror([0,y_offset,0]){ translate([screw_separation_x/2 ,screw_separation_y/2,box_z/2]) cylinder(h=4*wall_thickness, r = anchor_screw_radius, $fn=20, center = true);}}
			}}
		}
		
	}
	//mounting "legs"
	difference()
	{
	union(){
	for(y_offset = [0:1]){mirror([0,y_offset,0]){
		translate([(box_x + leg_x)/2,(box_y+leg_y)/2 - leg_y,(box_z - wall_thickness)/2])
		{		
			cube([leg_x,leg_y,leg_z],center = true);
			translate([-leg_x/2-wall_thickness,0,0])
			{
				difference()
				{
					rotate([90,0,0]) cylinder(h=leg_y,r = leg_x/2, $fn = 20, center = true);
					translate([0,0,leg_x/2]) cube([leg_x+1,leg_y+1,leg_x],center = true);
					translate([-leg_x/2,0,0]) cube([leg_x+1,leg_y+1,leg_x],center = true);
				}
			}
		}
	}}}
	translate([anchor_screw_x_offset,0,0])
		{
			for(x_offset = [0:1]){for(y_offset = [0:1]){
				mirror([x_offset,0,0]){ mirror([0,y_offset,0]){ translate([screw_separation_x/2 ,screw_separation_y/2,box_z/2]) cylinder(h=4*wall_thickness, r = anchor_screw_radius, $fn=20, center = true);}}
			}}
		}
	}
	//box lid screw posts
	for(x_offset = [0:1]){for(y_offset = [0:1]){
		mirror([x_offset,0,0]){ mirror([0,y_offset,0]){ 
			difference()
			{
				translate([(box_x-3*wall_thickness)/2,(box_y-3*wall_thickness)/2,0]) cylinder(h=box_z-2*wall_thickness, r = wall_thickness*1.5, $fn=20, center = true);
				translate([(box_x-3*wall_thickness)/2,(box_y-3*wall_thickness)/2,0]) cylinder(h=box_z, r = screw_radius, $fn=20, center = true);
			}
		}}
	}}
}
//*/
//radio block
//cube([board_x,board_y,board_z],center= true);
/*
//top cover
translate([0,0,-40])
{	
	difference()
	{
		union()
		{
			cube([box_x,box_y,wall_thickness], center = true);
			translate([0,0,wall_thickness*1.5]) cube([box_x-wall_thickness*7, box_y-wall_thickness*7, wall_thickness*3], center = true);
			//box lid screw holes
		for(x_offset = [0:1]){for(y_offset = [0:1]){
			mirror([x_offset,0,0]){ mirror([0,y_offset,0]){ 
				difference()
				{
					translate([(box_x-3*wall_thickness)/2,(box_y-3*wall_thickness)/2,0]) cylinder(h=wall_thickness*1.2, r = wall_thickness*1.5, $fn=20, center = true);
					translate([(box_x-3*wall_thickness)/2,(box_y-3*wall_thickness)/2,0]) cylinder(h=box_z, r = screw_radius, $fn=20, center = true);
				}
			}}
		}}
		}
		cube([heatsink_x, heatsink_y, wall_thickness*7],center = true);
	}
}
*/