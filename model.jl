mutable struct Model 
    myidx::Int64
    myseries::Vector{Float64} 
end
function Model()
    return Model(1, [])
end

function update!(model::Model)
    # do some updating things, poll sensors in lab, etc. Make a random RGB image
    model.myidx += 1
    push!(model.myseries, model.myidx)
end

function startmodel!(model::Model)
    Threads.@spawn begin
        while true
            update!(model::Model)
            sleep(0.1)
        end
    end
end