tolerance = 0.5;
inch_to_mm = 25.4;
board_x = 91.6 + tolerance;
board_y = 54.2 + tolerance;
board_z = 17.9 + tolerance;
top_heat_sink_x = 50.8 + tolerance;
top_heat_sink_y = 45.7 + tolerance;
bottom_heat_sink_x = 76.2 + tolerance;
bottom_heat_sink_y = 45.7 + tolerance;
//figure out whether to to trim power/data port board for height
pow_data_port_z = 36.1 + tolerance;
//pow_data_port_z = 12.7 + tolerance;
pow_data_port_x = 5.9 + tolerance;
x = board_x + pow_data_port_x;
y = board_y;
z = max(board_z,pow_data_port_z)  + tolerance;
pow_data_port_diameter = 13.8 + tolerance;
pow_data_port_flange_diameter = 17.0 + tolerance;
pow_data_port_separation = 25.4; //zero tolerance
led_diameter = 5.79  + tolerance;
led_flange_diamter = 7.8 + tolerance;
antenna_diameter = 5.8 + tolerance;
antenna_flange_diameter = 8.0 + tolerance;
antenna_separation = 40.6; //flexible 
screw_diameter = 1.25;  //tbd but 1.25 looks reasonable 
screw_length = 12.5; //tbd but 1.25 looks reasonable
ziptie_width = 4.0; //tbd but 4 looks reasonable
cap_offset = x;
wall_thickness = 3.175;
screw_head_diameter = screw_diameter + wall_thickness/2;

//zip tie openings
module ZiptieOpening(x,y,z)
{
    translate([x,y,z])
     {
        difference()
        {
            cube([3*ziptie_width,2*wall_thickness,wall_thickness],center = true);
            translate([0,0,-wall_thickness/2]) cube([ziptie_width, 2*wall_thickness+tolerance,wall_thickness], center= true);
            translate([ziptie_width*sqrt(2),0,1]) rotate([0,45,0]) cube([2*ziptie_width,3*wall_thickness, wall_thickness], center= true);
            translate([-ziptie_width*sqrt(2),0,1]) rotate([0,-45,0]) cube([2*ziptie_width,3*wall_thickness, wall_thickness], center= true);
        }
    }
}




//create box and openings
    translate([0,0,0])
{
difference()
{
union()
{
    //box openings
    difference()
    {
        cube([x+2*wall_thickness, y + 2*wall_thickness, z + 2*wall_thickness],center = true);
        //hollow out the case to a thickness of wall_thickness
        translate([0,0,0]) {cube([x,y,z],center = true);}
        //opening for top heat sink
        translate([0,0,(z+wall_thickness)/2]) {cube([top_heat_sink_x,top_heat_sink_y,2*wall_thickness],center = true);}
        //opening for bottom heat sink
        translate([0,0,(-z-wall_thickness)/2]) {cube([bottom_heat_sink_x,bottom_heat_sink_y,2*wall_thickness],center    = true);}
        //openings for power/data ports
        for (y_offset = [0:1])
        {
            mirror([0,y_offset,0])
            translate([-x/2,pow_data_port_separation/2,-(z-pow_data_port_flange_diameter)/2]) {rotate([0,90,0]){cylinder(h=4*wall_thickness, r    = pow_data_port_diameter/2, $fn=100, center = true);}}
        }
        //opening for led indicator
        translate([-x/2,0,0]) {rotate([0,90,0]){cylinder(h=4*wall_thickness, r = led_diameter/2, $fn=100, center = true);}}
        //opening for antennae
        for (y_offset = [0:1])
        {
         mirror([0,y_offset,0])
        translate([-x/2,antenna_separation/2,(z-antenna_flange_diameter)/2]) {rotate([0,90,0]){cylinder(h=4*wall_thickness, r =       antenna_diameter/2, $fn=100, center = true);}}
        }
        //opening at the back to slide the board in
        translate([x/2,0,0]) {cube([4*wall_thickness,y,z],center = true);}
    }
    
    //mirror zip tie openings on top bottom
    for (x_offset = [0:1])
    {
        for (y_offset = [0:1])
        {
            for (z_offset = [0:1])
            {
                mirror([x_offset,0,0]) 
                mirror([0,y_offset,0]) 
                mirror([0,0,z_offset])
                ZiptieOpening(x/2 - wall_thickness,y/2 - wall_thickness,z/2 + 3/2 * wall_thickness);
    
            }
        }
    }
    
    //screw cavities on side
    for (y_offset = [0:1])
    {
    mirror([0,y_offset,0])
    translate([(x-screw_length)/2 ,(y/2),0]) 
    {
        difference()
        {
            rotate([0,90,0]){cylinder(h=  screw_length * 1.5, r = screw_diameter + wall_thickness/2, $fn=100, center = true);}
            translate ([-screw_length,0,0]) rotate([0,0,-45]) cube([8*screw_diameter+wall_thickness,screw_diameter+wall_thickness,3*screw_diameter+wall_thickness],center = true);
        }
    
    }
    }
       
  
}

//screw holes
for (y_offset = [0:1])
{
mirror([0,y_offset,0])
translate([(x-screw_length)/2 + 2*wall_thickness,(y/2),0]) {rotate([0,90,0]){cylinder(h=screw_length+wall_thickness, r = screw_diameter, $fn=100, center = true);}}
translate([(x-screw_length)/2 + 2*wall_thickness,-(y/2),0]) {rotate([0,90,0]){cylinder(h=screw_length+ wall_thickness, r = screw_diameter, $fn=100, center = true);}}

}
}



//back cover
difference()
{
union()
{
    //back cover
    translate([cap_offset,0,0]) {cube([wall_thickness*2,y-tolerance,z-tolerance],center = true);}
    translate([cap_offset+wall_thickness,0,0]) {cube([wall_thickness*2,y+2*wall_thickness,z+2*wall_thickness],center = true);}
    //screw cylinders for strength
    for (y_offset = [0:1])
    {
    mirror([0,y_offset,0])
    translate([cap_offset+ wall_thickness,(y/2),0]) {rotate([0,90,0]){cylinder(h=2*wall_thickness,r = screw_diameter + wall_thickness/2, $fn=100, center = true);}}
    }
}
    //screw cavitities  
    for (y_offset = [0:1])
    {
    mirror([0,y_offset,0])
    {
    translate([cap_offset+ wall_thickness,(y/2),0]) {rotate([0,90,0]){cylinder(h=3*wall_thickness,r = screw_diameter, $fn=100, center = true);}} 
    translate([cap_offset+ 2*wall_thickness,(y/2),0]) {rotate([0,90,0]){cylinder(h=wall_thickness,r = screw_head_diameter, $fn=100, center = true);}}
    }
    }
}
}

