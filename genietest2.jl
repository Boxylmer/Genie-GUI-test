using GenieFramework 

include("model.jl")

@genietools 

model = Model()

@handlers begin
    @in x = 1.0
    @in y = 2.0
    @out u_x = []
    @out u_y = []
    @in start = false
    @out model = Model()  # doesn't seem to be updating for some reason
    
    @onchange start begin
        y+=4  # this DOES work, but isn't contained
        println(start)
    end
    
end
startmodel!(model)


include("custom_layout.jl")


function ui()
    [
    row([
        cell(class="st-module", bignumber("x", R"model.myidx" ) )
        cell(class="st-module", style="color: red;", [  # color doesnt' work :( not very important at the moment though
                h6("y1")
                textfield("", :y)
            ])
        cell(class="st-module", [
            h6("ux1")
            slider(0:0.01:0.1, :u_x ; label=true)
        ])
        btn("Start!", percentage=R"model.myidx", flat=true, ripple=false, style="color: red;", loading=R"model.loading", @click("start = !start"))
    ])
    row([
        # cell(class="st-module", plot(:solplot))
        cell(class="st-module", [
            h6("ux")
        ])
        # cell(class="st-module", style="", [
        #         cell(style="font-size:20px;text-align:center;padding-top:50px", latex" \text{\large Lorenz equations} \\ \dot{x}  = \sigma(y-x) \\ \dot{y}  = \rho x - y - xz \\ \dot{z}  = -\beta z + xy "auto )
        # ])
    ])
    row(style="text-align:center; color:#8d99ae;", [
        cell([
            footer(class="text-muted", style="text-align:center", "test")
        ])
    ])
    ]
end

@page("/", ui, LAYOUT)
Server.isrunning() || Server.up()
