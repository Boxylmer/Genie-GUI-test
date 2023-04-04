using Stipple, Stipple.ReactiveTools
using StippleUI

# @appname Inverter

@app ModelVars begin
    myp = false
end

function ui()
  row(cell(class = "st-module", [
    textfield(class = "q-my-md", "Input", :input, hint = "I'm afraid of what the internet will put here.", @on("keyup.enter", "myp = true"))
    textfield(class = "q-my-md", "Input", :input, hint = "Please enter some words", @on("keyup.enter", "process = true"))

    btn(class = "q-my-md", "Action!", @click(:process), color = "red")
    
    card(class = "q-my-md", [
      card_section(h2("Output"))
      card_section("Variant 1: {{ output }}")
      card_section(["Variant 2: ", span(class = "text-red", @text(:output))])
    ])
  ]))
end

route("/") do
  model = @init
  page(model, ui()) # |> html
end

Genie.isrunning(:webserver) || up()