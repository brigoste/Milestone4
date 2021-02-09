using Plots

struct Source_Point
    posX             #array [xpos, ypos]
    posY
    Λ               #Magnitude. Lambda
end
struct Sink_Point
    posX
    posY
    Λ
end
struct Freestream
    Λ
    direction       #to the right
end
struct Vortex_Point
    posX             #[posx,posy]
    posY
    Λ
    direction
end
struct Point_Matrix         #This is to make the points we are testing.
    posX
    posY
    velX
    velY
end

function distance_finder(x1, y1, x2, y2)
    r = sqrt((x1-x2)^2 + (y1-y2)^2);

    return r;
end
function main()
    xVals = 0;   #X Values
    yVals = 0;   #Y Values

    # Points = [xVals, yVals]

    # scatter(xVals, yVals);

    source1 = Source_Point(1,0,2);  #located at (1,1) and has strength  of 2.
    sink1 = Sink_Point(9,0,1);       #Sink located at (9,1), stength of 1.
    vortex1 = Vortex_Point(5,0,1,1);   #Vortex located at (2,2), stength of 1, direction out of chart.

    # source_Plot = scatter([source1.posX, source1.posY], label = "Source")
    # sink_Plot = scatter!([sink1.posX, sink1.posY], label = "Sink")
    # vortex_Plot = scatter!([vortex1.posX, vortex1.posY], label = "Vortex")

    evaluation_Points  = Point_Matrix[][];

    #This is where we need to bulid a mesh around the airfoil
    for i = 0 to 20
        for j = 6 to 20
            evaluation_Points[i][j - 6] = Point_Matrix(i, j, 0, 0);  #constructor
        end
    end
    for i in evaluation_Points
        for j in evaluation_Points[i]
            evalutation_Points[i][(-j)+14] = Point_Matrix(i, -j, 0, 0);
        end
    end

    plotname = plot();
    p1 = display(scatter!([source1.posX], [source1.posY], label = "Source", markersize = 8, markercolor = [:red]))
    p2 = display(scatter!([sink1.posX], [sink1.posY], label = "Sink", markersize = 8, markercolor = [:black]))
    p3 = display(scatter!([vortex1.posX], [vortex1.posY], label = "Vortex", markersize = 8, markercolor = [:blue]))
    for i = 0 to 20
        for j = 0 to 40
            p4 = display(scatter!(evaluation_Points[i][j].posX, evaluation_Points[i][j].posY))
        end
    end
    xlims!(0, 10);
    ylims!(-10, 10);

    # savefig(plotname, "plots.pdf")

    #Velocity of each point around airfoil has an x and y component.

    #Sources - Influenced VELOCITY
    # V_vector = Λ / (2*π*r)
    # Vx = (Λ)cos(θ) / (2*π*r)        (1)
    # Vy = (Λ)sin(θ) / (2*π*r)         (2)

    #Vortex = Influenced Velocity
    # V_vector = -(Γ) / 2*π*r
    # Vx = Γ*sin(θ) / 2*π*r     #Components
    # Vy = -Γ*cos(θ) / 2*π*r

    #This is what I understand:
    #   We have a lattice of points around and airfoil representing the air passing over the airfoil.
    #   At each point, the air speed/direction is affected by the Vortex, source, sink, and Freestream.
    #The Flow Field adds a straight up velocity to the right.
    #The Source and sink act as a force that pulls/pushes on the point. Like the vortex their influence on the point, or their induced velocity, is expressed in Equations (1) and (2). r is the distance between the point and the anomoly.

    #Therefore we need to:
    #   1. Determine the location of the source, sink, and vortex.
    #   2. Determine the magnitude of the source, sink, vortex, and filed flow
    #   3. Define area of Airfoil based upon the locations of the anomolies.
    #   4. Create a lattice of points around airfoil.
    #   5. Determine resultant velocity at each point based on their relative position to each anomoly.
    #   6. Plot the results as a quiver().
    #   6b. Download the .dat file of used airfoil, and superimpose of plot.
    #   7. Determine Pressure at each point (eq 2.102) SUPER EASY. Try Making a Color Plot, if you can.

end

main();
