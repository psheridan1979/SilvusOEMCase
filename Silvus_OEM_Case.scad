matrice_x = 98.1;
matrice_y = 100.1;
matrice_z = 26.4;
wall_thickness = 3.175/2;
tolerance = 0.5;
board_x = 91.6;
board_y = 54.2;
board_z = 19.8;
pow_data_port_diameter = 13.8;
pow_data_port_x = 6.5;
pow_data_port_flange_diameter = 17.0;
pow_data_port_separation = 25.4;
led_diameter = 5.79;
led_flange_diamter = 7.8;
antenna_port_diameter = 5.8;
antenna_flange_diameter = 8.0;
antenna_port_offset = board_x - 37.0; //flexible
antenna_separation = 92.9;
screw_diameter = 1.25;  //tbd but 1.25 looks reasonable 
screw_head_diameter = 2.5; //tbd
screw_length = 12.5; //tbd but 12.5 looks reasonable
ziptie_width = 4.0; //tbd but 4 looks reasonable


cavity_x = board_x + pow_data_port_x + tolerance;
cavity_y = antenna_separation - tolerance;
cavity_z = board_z + tolerance;
box_x = cavity_x + 2* wall_thickness;
box_y = cavity_y + 2* wall_thickness;
box_z = cavity_z + 2* wall_thickness;
heat_sink_x = board_x /2;
heat_sink_y = board_y;
heat_sink_z = (matrice_z - box_z) / 2; 
screw_head_diameter = screw_diameter + wall_thickness/2;
//box without lid
union()
{
    //basic box shape and openings
    difference()
    {
        cube([box_x, box_y, box_z], center = true);
        //hollow out box
        cube([cavity_x,cavity_y,cavity_z], center = true);
        //remove top
        translate([0,0,box_z/2]) cube([cavity_x, cavity_y, wall_thickness*3], center = true);
        //mirroring for y symmetrical ports
        for (y_offset = [0:1])
        {
            mirror([0,y_offset,0])
            {
                //power/data port openings
                translate([box_x/2,pow_data_port_separation/2,0]) rotate([0,90,0]) cylinder(h=wall_thickness*3,r= pow_data_port_diameter/2, center = true);
                //antenna port openings
                translate([antenna_port_offset/2,box_y/2,0]) rotate([90,0,0]) cylinder(h=wall_thickness*3, r= antenna_port_diameter/2, center = true);
            }
        }
        // led opening
        // vertical offset is arbitrary but it has to be higher than the power/data ports but near them
        translate([box_x/2,0,4]) rotate([0,90,0]) cylinder(h=wall_thickness*3,r= led_diameter/2, center = true);
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
        }
    }
}

//lid
translate([0,0,2*box_z])
{
    union()
    {
        cube([box_x, box_y, wall_thickness], center = true);
            //hollow out box
        translate([0,0,-wall_thickness]) cube([cavity_x-tolerance,cavity_y-tolerance,2*wall_thickness], center = true);
            //remove top
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
                        translate([cavity_x/2-wall_thickness,cavity_y/2-wall_thickness,tolerance]) cylinder(h=wall_thickness, r=wall_thickness*2, center = true);
                        translate([cavity_x/2-wall_thickness,cavity_y/2-wall_thickness,tolerance]) cylinder(h=wall_thickness, r=screw_diameter/2, center = true);
                    }
                }
            }
        }
    }
}