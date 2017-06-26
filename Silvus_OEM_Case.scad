tolerance = 0.5;
cavity_x = 98.1;
cavity_y = 100.1;
cavity_z = 26.4;
board_x = 91.6 + tolerance;
board_y = 54.2 + tolerance;
board_z = 17.9 + tolerance;
top_heat_sink_x = board_x /2;
top_heat_sink_y = board_x;
//top_heat_sink_z = ;//tbd
bottom_heat_sink_x = board_x /2;
bottom_heat_sink_y = board_y;
//bottom_heat_sink_z = ;//tbd
//figure out whether to to trim power/data port board for height
//pow_data_port_z = 36.1 + tolerance;
pow_data_port_z = 19.5 + tolerance;
pow_data_port_x = 5.9 + tolerance;
pow_data_port_diameter = 13.8 + tolerance;
pow_data_port_flange_diameter = 17.0 + tolerance;
pow_data_port_separation = 25.4; //zero tolerance
led_diameter = 5.79  + tolerance;
led_flange_diamter = 7.8 + tolerance;
antenna_diameter = 5.8 + tolerance;
antenna_flange_diameter = 8.0 + tolerance;
antenna_port_offset = board_x - 37.0; //flexible
antenna_separation = 92.9;
screw_diameter = 1.25;  //tbd but 1.25 looks reasonable 
screw_length = 12.5; //tbd but 1.25 looks reasonable
ziptie_width = 4.0; //tbd but 4 looks reasonable
wall_thickness = 3.175;
screw_head_diameter = screw_diameter + wall_thickness/2;
<<<<<<< HEAD
///*
//box without lid
=======
x = board_x + pow_data_port_x;
y = max(cavity_y, antenna_separation);
z = max(board_z,pow_data_port_z)  + tolerance;
cap_offset = x;
updown = 1;

//create box and openings
//make same box twice and mirror to eliminate bottom and top sections 
for (z_offset = [0:1])
{
mirror([0,0,z_offset])
{
if (z_offset == 0) 
{
    updown = -1;
}
translate([0,0,updown * 2* z])
{
>>>>>>> parent of cc0bf51... this will probably work, needs mounting for screws
union()
{
    //box openings
    difference()
    {
        cube([x+2*wall_thickness, y + 2*wall_thickness, z + 2*wall_thickness],center = true);
        //hollow out the case to a thickness of wall_thickness
        translate([0,0,0]) {cube([x,y,z],center = true);}
        
        //make top cover by splitting two identical cases
        if (z_offset == 0)
        {
            translate([0,0, -wall_thickness]) cube([x+3*wall_thickness,y+3*wall_thickness,z+3*wall_thickness],center = true);
        }
        else
        {
            translate([0,0, -z-2*wall_thickness]) cube([x+3*wall_thickness,y+3*wall_thickness,z+4*wall_thickness+tolerance],center = true);
        }
        
        //opening for heat sinks
        for (z_offset = [0:1])
        {
         mirror([0,0,z_offset])
        translate([0,0,(-z-wall_thickness)/2]) {cube([bottom_heat_sink_x,bottom_heat_sink_y,2*wall_thickness],center    = true);}
        }
        //openings for power/data ports
        for (y_offset = [0:1])
        {
            mirror([0,y_offset,0])
            translate([-x/2,pow_data_port_separation/2,0]) {rotate([0,90,0]){cylinder(h=4*wall_thickness, r    = pow_data_port_diameter/2, $fn=100, center = true);}}
        }
<<<<<<< HEAD
        // led opening
        // vertical offset is arbitrary but it has to be higher than the power/data ports but near them
        translate([box_x/2,0,4]) rotate([0,90,0]) cylinder(h=wall_thickness*3,r= led_diameter/2, center = true);
        // heat sink opening
        translate([0,0,-box_z/2]) cube([heat_sink_x, heat_sink_y, 10], center = true);
    }
    //screw posts
    //mirroring to put one in each corner
    for (x_offset = [0:1])
    {
        mirror([x_offset,0,0])
        {    
            for (y_offset = [0:1])
            {
                mirror([0,y_offset,0])
                {  
                    difference()
                    {
                        translate([cavity_x/2-wall_thickness,cavity_y/2-wall_thickness,0]) cylinder(h=cavity_z, r=wall_thickness*2, center = true);
                        translate([cavity_x/2-wall_thickness,cavity_y/2-wall_thickness,0]) cylinder(h=cavity_z, r=screw_diameter/2, center = true);
                    }
                }
            }
=======
        //opening for led indicator
        translate([-x/2,0,0]) {rotate([0,90,0]){cylinder(h=4*wall_thickness, r = led_diameter/2, $fn=100, center = true);}}
        //opening for antennae
        for (y_offset = [0:1])
        {
         mirror([0,y_offset,0])
        translate([-antenna_port_offset/2,y/2,0]) {rotate([0,90,90]){cylinder(h=4*wall_thickness, r =       antenna_diameter/2, $fn=100, center = true);}}
>>>>>>> parent of cc0bf51... this will probably work, needs mounting for screws
        }
        //opening at the back to slide the board in
        //translate([x/2,0,0]) {cube([4*wall_thickness,y,z],center = true);}
    }
<<<<<<< HEAD
    //guide rails for radio
    for (y_offset = [0:1])
    {
    mirror([0,y_offset,0]) translate([0,board_y/2 + wall_thickness,-board_z/2]) cube([board_x,wall_thickness,wall_thickness*2], center = true);
    }
}
//*/
///*
//lid
translate([0,0,2*box_z])
{
    difference()
    {
        union()
        {
            cube([box_x, box_y, wall_thickness], center = true);
            translate([0,0,-wall_thickness]) cube([cavity_x-tolerance,cavity_y-tolerance,2*wall_thickness], center = true);
            //guide rails for radio
            for (y_offset = [0:1])
            {
            mirror([0,y_offset,0]) translate([0,board_y/2 + wall_thickness,-wall_thickness*2]) cube([board_x,wall_thickness,wall_thickness*2], center = true);
            }
            
        }
        // heat sink opening
        translate([0,0,0]) cube([heat_sink_x, heat_sink_y, 10], center = true);
    }
    //screw posts
    //mirroring to put one in each corner
=======
    
    
       
  
    //screw cavities
>>>>>>> parent of cc0bf51... this will probably work, needs mounting for screws
    for (x_offset = [0:1])
    {
        for (y_offset = [0:1])
        {
            mirror([x_offset,0,0]) mirror([0,y_offset,0]) 
            {
                translate([x/2 -wall_thickness, y/2 - wall_thickness, 0]) rotate([0,0,0])
                {
                    difference()
                    {
                        cylinder(h = z + wall_thickness*3, r = screw_diameter+wall_thickness, $fn=20, center = true);
                        cylinder(h = z + wall_thickness*4, r = screw_diameter, $fn=20, center = true);
                    }
                }
            }
        }
    }
}
<<<<<<< HEAD
//*/
=======
}
}
}
>>>>>>> parent of cc0bf51... this will probably work, needs mounting for screws
