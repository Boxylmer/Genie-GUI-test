mutable struct Model 
    myidx::Int64
    myseries::Vector{Float64}
    loading::Bool
end
function Model()
    return Model(1, [], true)
end

function update!(model::Model)
    # do some updating things, poll sensors in lab, etc. Make a random RGB image
    model.myidx += 1
    push!(model.myseries, model.myidx)
    if model.myidx > 100
        model.loading=false
    end

    println(model.myidx, model.loading)
end

function startmodel!(model::Model)
    Threads.@spawn begin
        while true
            update!(model::Model)
            sleep(1)
        end
    end
end