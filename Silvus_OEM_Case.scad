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
        //opening for led indicator
        translate([-x/2,0,0]) {rotate([0,90,0]){cylinder(h=4*wall_thickness, r = led_diameter/2, $fn=100, center = true);}}
        //opening for antennae
        for (y_offset = [0:1])
        {
         mirror([0,y_offset,0])
        translate([-antenna_port_offset/2,y/2,0]) {rotate([0,90,90]){cylinder(h=4*wall_thickness, r =       antenna_diameter/2, $fn=100, center = true);}}
        }
        //opening at the back to slide the board in
        //translate([x/2,0,0]) {cube([4*wall_thickness,y,z],center = true);}
    }
    
    
       
  
    //screw cavities
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
}
}
}
