board_x = 3.605;
board_y = 2.135;
board_z = 0.705;
top_heat_sink_x = 2.0;
top_heat_sink_y = 1.8;
bottom_heat_sink_x = 3;
bottom_heat_sink_y = 1.8;
//figure out whether to to trim power/data port board for height
//pow_data_port_z = 1.364;
pow_data_port_z = 0.5;
pow_data_port_x = 0.232;
x = board_x + pow_data_port_x;
y = board_y;
z = max(board_z,pow_data_port_z);
pow_data_port_diameter = 0.545;
pow_data_port_separation = 1.0;
led_diameter = 0.228;
antenna_diameter = 0.228;
antenna_separation = 1.6;
screw_radius = 0.05;
screw_length = 0.5;
cap_offset = x;

wall_thickness = 1/8;

union()
{
    //back cover
    translate([cap_offset,0,0]) {cube([wall_thickness*2,y,z],center = true);}
    translate([cap_offset+wall_thickness,0,0]) {cube([wall_thickness*2,y+wall_thickness,z+wall_thickness],center = true);}
    //screw cavities on side
    difference()
    {
        translate([cap_offset+ wall_thickness,(y/2+wall_thickness),0]) {rotate([0,90,0]){cylinder(h=2*wall_thickness,r = screw_radius + wall_thickness/2, $fn=100, center = true);}}
        translate([cap_offset+ wall_thickness,(y/2+wall_thickness),0]) {rotate([0,90,0]){cylinder(h=3*wall_thickness,r = screw_radius, $fn=100, center = true);}}
    }
    difference()
    {
        translate([cap_offset+ wall_thickness,-(y/2+wall_thickness),0]) {rotate([0,90,0]){cylinder(h=2*wall_thickness, r = screw_radius + wall_thickness/2, $fn=100, center = true);}}
        translate([cap_offset+ wall_thickness,-(y/2+wall_thickness),0]) {rotate([0,90,0]){cylinder(h=3*wall_thickness, r = screw_radius, $fn=100, center = true);}}
    }
    
    
}