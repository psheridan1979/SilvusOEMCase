tolerance = 0.6;
space_x = 100;
space_y = 100;
space_z = 35;
board_x = 92;
board_y = 55;
board_z = 20;


//bottom_heat_sink_z = ;//tbd
//figure out whether to to trim power/data port board for height
//pow_data_port_z = 36.1 + tolerance;
pow_data_port_radius = 8.5;
pow_data_port_separation = 25.5; //zero tolerance
led_radius = 4;
antenna_radius = 4;
antenna_separation = 92.9;
antenna_x_offset = 20;

screw_radius = 0.5;  //tbd but 0.5 looks reasonable 
screw_length = 10; //tbd but 10 looks reasonable
screw_head_radius = 1; //tbd 
ziptie_width = 4.0; //tbd but 4 looks reasonable
wall_thickness = 2.0;

screw_separation = 80;

box_x = space_x;
box_y = antenna_separation;
box_z = space_z;

difference()
{
	cube([box_x,box_y,box_z], center = true);
	cube([box_x-wall_thickness*2,box_y-wall_thickness*2,box_z-wall_thickness*2], center = true); 
	translate([0,0,-(box_z-wall_thickness)/2]) cube([box_x+1,box_y+1,wall_thickness+1],center = true);
	//openings for power/data ports
	for (y_offset = [0:1])
	{
		mirror([0,y_offset,0])
		translate([-box_x/2,pow_data_port_separation/2,-space_z/8]) rotate([0,90,0]) cylinder(h=4*wall_thickness, r    = pow_data_port_radius, $fn=20, center = true);
	}
	//opening for led indicator
    translate([-box_x/2,0,space_z/8]) rotate([0,90,0]) cylinder(h=4*wall_thickness, r = led_radius, $fn=20, center = true);
	//opening for antennae
	for (y_offset = [0:1])
	{
	 mirror([0,y_offset,0])
	translate([-antenna_x_offset,box_y/2,0]) rotate([0,90,90]) cylinder(h=4*wall_thickness, r = antenna_radius, $fn=100, center = true);
	}
	//box mounting screw holes
	for(x_offset = [0:1]){for(y_offset = [0:1]){
		mirror([x_offset,0,0]){ mirror([0,y_offset,0]){ translate([screw_separation/2,screw_separation/2,box_z/2]) cylinder(h=4*wall_thickness, r = screw_radius, $fn=20, center = true);}}
	}}
}
//box mounting screw holes

for(x_offset = [0:1]){for(y_offset = [0:1]){
	mirror([x_offset,0,0]){ mirror([0,y_offset,0]){ 
		difference()
		{
			translate([(box_x-2*wall_thickness)/2,(box_y-2*wall_thickness)/2,0]) cylinder(h=box_z-2*wall_thickness, r = wall_thickness, $fn=20, center = true);
			translate([(box_x-2*wall_thickness)/2,(box_y-2*wall_thickness)/2,0]) cylinder(h=box_z, r = screw_radius, $fn=20, center = true);
		}
	}}
}}
