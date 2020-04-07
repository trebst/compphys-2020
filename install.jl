using Pkg

get_global_env() = string("v", VERSION.major, ".", VERSION.minor)
get_global_env_folder() = joinpath(DEPOT_PATH[1], "environments", get_global_env())
get_active_env() = Base.active_project() |> dirname |> basename

# activate global environment (if not already active)
function activate_global_env()
    if get_active_env() != get_global_env()
        Pkg.REPLMode.pkgstr("activate --shared $(get_global_env())")
    end 
    nothing
end

function rm_global_env()
    if isdir(get_global_env_folder())
        cd(get_global_env_folder()) do
            isfile("Project.toml") && rm("Project.toml")
            isfile("Manifest.toml") && rm("Manifest.toml")
        end
    end
    nothing
end

# Installs all correct versions of our package dependencies.
function install()
    activate_global_env()

    # add all pkgs with specific versions (not pinned)
    @info "Installiere alle Pakete..."
    pkg"add HDF5@0.13.0 CSV@0.5.26 Cubature@1.4.1 Distributions@0.22.5 CSVFiles@1.0.0 BenchmarkTools@0.5.0 Measurements@2.2.0 Formatting@0.4.1 PyCall@1.91.4 LaTeXStrings@1.1.0 Traceur@0.3.0 ColorTypes@0.10.0 LsqFit@0.10.0 PyPlot@2.8.2 Polynomials@0.6.1 ProgressMeter@1.2.0 DifferentialEquations@6.11.0 ExcelFiles@1.0.0 DataFrames@0.20.2 QuantumOptics@0.7.1 FFTW@1.2.0"

    # precompile
    @info "Bereite alle Pakete vor...."
    pkg"precompile"
end


# Installs all correct versions of our package dependencies
# by overwriting(!) the existing global environment.
function install_overwrite()
    rm_global_env()
    activate_global_env()

    # install IJulia
    @info "Installiere IJulia"
    pkg"add IJulia"

    # add all pkgs with specific versions (not pinned)
    @info "Installiere alle Pakete..."
    pkg"add HDF5@0.13.0 CSV@0.5.26 Cubature@1.4.1 Distributions@0.22.5 CSVFiles@1.0.0 BenchmarkTools@0.5.0 Measurements@2.2.0 Formatting@0.4.1 PyCall@1.91.4 LaTeXStrings@1.1.0 Traceur@0.3.0 ColorTypes@0.10.0 LsqFit@0.10.0 PyPlot@2.8.2 Polynomials@0.6.1 ProgressMeter@1.2.0 DifferentialEquations@6.11.0 ExcelFiles@1.0.0 DataFrames@0.20.2 QuantumOptics@0.7.1 FFTW@1.2.0"

    # precompile
    @info "Bereite alle Pakete vor...."
    pkg"precompile"
end

nothing
