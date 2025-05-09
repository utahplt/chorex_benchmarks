defmodule BigChor do
  import Chorex

  defchor [Dispatch, Worker1, Worker2, Worker3, Worker4, Worker5, Worker6, Worker7, Worker8, Worker9, Worker10, Worker11, Worker12, Worker13, Worker14, Worker15, Worker16, Worker17, Worker18, Worker19, Worker20, Worker21, Worker22, Worker23, Worker24, Worker25, Worker26, Worker27, Worker28, Worker29, Worker30, Worker31, Worker32, Worker33, Worker34, Worker35, Worker36, Worker37, Worker38, Worker39, Worker40, Worker41, Worker42, Worker43, Worker44, Worker45, Worker46, Worker47, Worker48, Worker49, Worker50, Worker51, Worker52, Worker53, Worker54, Worker55, Worker56, Worker57, Worker58, Worker59, Worker60, Worker61, Worker62, Worker63, Worker64, Worker65, Worker66, Worker67, Worker68, Worker69, Worker70, Worker71, Worker72, Worker73, Worker74, Worker75, Worker76, Worker77, Worker78, Worker79, Worker80, Worker81, Worker82, Worker83, Worker84, Worker85, Worker86, Worker87, Worker88, Worker89, Worker90, Worker91, Worker92, Worker93, Worker94, Worker95, Worker96, Worker97, Worker98, Worker99, Worker100] do
    def run(Dispatch.(try?), Worker1.(x)) do
      if Dispatch.(try?) do
        daisy_try(Worker1.(x))
      else
        daisy_no_try(Worker1.(x))
      end
    end

    def daisy_try(Worker1.(x)) do
      try do
        with Worker1.(y) <- work(Worker1.(x)) do
          try do
            with Worker1.(z) <- work(Worker1.(y)) do
              try do
                work(Worker1.(z))
              rescue
                Worker1.(:boom2)
              end
            end
          rescue
            Worker1.(:boom1)
          end
        end
      rescue
        Worker1.(:boom0)
      end
    end

    def daisy_no_try(Worker1.(x)) do
      with Worker1.(y) <- work(Worker1.(x)) do
        with Worker1.(z) <- work(Worker1.(y)) do
          work(Worker1.(z))
        end
      end
    end

    def work(Worker1.(x)) do
      Worker1.work_hard(x) ~> Worker2.(x)
      Worker2.work_hard(x) ~> Worker3.(x)
      Worker3.work_hard(x) ~> Worker4.(x)
      Worker4.work_hard(x) ~> Worker5.(x)
      Worker5.work_hard(x) ~> Worker6.(x)
      Worker6.work_hard(x) ~> Worker7.(x)
      Worker7.work_hard(x) ~> Worker8.(x)
      Worker8.work_hard(x) ~> Worker9.(x)
      Worker9.work_hard(x) ~> Worker10.(x)
      Worker10.work_hard(x) ~> Worker11.(x)
      Worker11.work_hard(x) ~> Worker12.(x)
      Worker12.work_hard(x) ~> Worker13.(x)
      Worker13.work_hard(x) ~> Worker14.(x)
      Worker14.work_hard(x) ~> Worker15.(x)
      Worker15.work_hard(x) ~> Worker16.(x)
      Worker16.work_hard(x) ~> Worker17.(x)
      Worker17.work_hard(x) ~> Worker18.(x)
      Worker18.work_hard(x) ~> Worker19.(x)
      Worker19.work_hard(x) ~> Worker20.(x)
      Worker20.work_hard(x) ~> Worker21.(x)
      Worker21.work_hard(x) ~> Worker22.(x)
      Worker22.work_hard(x) ~> Worker23.(x)
      Worker23.work_hard(x) ~> Worker24.(x)
      Worker24.work_hard(x) ~> Worker25.(x)
      Worker25.work_hard(x) ~> Worker26.(x)
      Worker26.work_hard(x) ~> Worker27.(x)
      Worker27.work_hard(x) ~> Worker28.(x)
      Worker28.work_hard(x) ~> Worker29.(x)
      Worker29.work_hard(x) ~> Worker30.(x)
      Worker30.work_hard(x) ~> Worker31.(x)
      Worker31.work_hard(x) ~> Worker32.(x)
      Worker32.work_hard(x) ~> Worker33.(x)
      Worker33.work_hard(x) ~> Worker34.(x)
      Worker34.work_hard(x) ~> Worker35.(x)
      Worker35.work_hard(x) ~> Worker36.(x)
      Worker36.work_hard(x) ~> Worker37.(x)
      Worker37.work_hard(x) ~> Worker38.(x)
      Worker38.work_hard(x) ~> Worker39.(x)
      Worker39.work_hard(x) ~> Worker40.(x)
      Worker40.work_hard(x) ~> Worker41.(x)
      Worker41.work_hard(x) ~> Worker42.(x)
      Worker42.work_hard(x) ~> Worker43.(x)
      Worker43.work_hard(x) ~> Worker44.(x)
      Worker44.work_hard(x) ~> Worker45.(x)
      Worker45.work_hard(x) ~> Worker46.(x)
      Worker46.work_hard(x) ~> Worker47.(x)
      Worker47.work_hard(x) ~> Worker48.(x)
      Worker48.work_hard(x) ~> Worker49.(x)
      Worker49.work_hard(x) ~> Worker50.(x)
      Worker50.work_hard(x) ~> Worker51.(x)
      Worker51.work_hard(x) ~> Worker52.(x)
      Worker52.work_hard(x) ~> Worker53.(x)
      Worker53.work_hard(x) ~> Worker54.(x)
      Worker54.work_hard(x) ~> Worker55.(x)
      Worker55.work_hard(x) ~> Worker56.(x)
      Worker56.work_hard(x) ~> Worker57.(x)
      Worker57.work_hard(x) ~> Worker58.(x)
      Worker58.work_hard(x) ~> Worker59.(x)
      Worker59.work_hard(x) ~> Worker60.(x)
      Worker60.work_hard(x) ~> Worker61.(x)
      Worker61.work_hard(x) ~> Worker62.(x)
      Worker62.work_hard(x) ~> Worker63.(x)
      Worker63.work_hard(x) ~> Worker64.(x)
      Worker64.work_hard(x) ~> Worker65.(x)
      Worker65.work_hard(x) ~> Worker66.(x)
      Worker66.work_hard(x) ~> Worker67.(x)
      Worker67.work_hard(x) ~> Worker68.(x)
      Worker68.work_hard(x) ~> Worker69.(x)
      Worker69.work_hard(x) ~> Worker70.(x)
      Worker70.work_hard(x) ~> Worker71.(x)
      Worker71.work_hard(x) ~> Worker72.(x)
      Worker72.work_hard(x) ~> Worker73.(x)
      Worker73.work_hard(x) ~> Worker74.(x)
      Worker74.work_hard(x) ~> Worker75.(x)
      Worker75.work_hard(x) ~> Worker76.(x)
      Worker76.work_hard(x) ~> Worker77.(x)
      Worker77.work_hard(x) ~> Worker78.(x)
      Worker78.work_hard(x) ~> Worker79.(x)
      Worker79.work_hard(x) ~> Worker80.(x)
      Worker80.work_hard(x) ~> Worker81.(x)
      Worker81.work_hard(x) ~> Worker82.(x)
      Worker82.work_hard(x) ~> Worker83.(x)
      Worker83.work_hard(x) ~> Worker84.(x)
      Worker84.work_hard(x) ~> Worker85.(x)
      Worker85.work_hard(x) ~> Worker86.(x)
      Worker86.work_hard(x) ~> Worker87.(x)
      Worker87.work_hard(x) ~> Worker88.(x)
      Worker88.work_hard(x) ~> Worker89.(x)
      Worker89.work_hard(x) ~> Worker90.(x)
      Worker90.work_hard(x) ~> Worker91.(x)
      Worker91.work_hard(x) ~> Worker92.(x)
      Worker92.work_hard(x) ~> Worker93.(x)
      Worker93.work_hard(x) ~> Worker94.(x)
      Worker94.work_hard(x) ~> Worker95.(x)
      Worker95.work_hard(x) ~> Worker96.(x)
      Worker96.work_hard(x) ~> Worker97.(x)
      Worker97.work_hard(x) ~> Worker98.(x)
      Worker98.work_hard(x) ~> Worker99.(x)
      Worker99.work_hard(x) ~> Worker100.(x)
      Worker100.work_hard(x) ~> Worker1.(x)

      Worker1.(x)
    end
  end
end

defmodule Worker1Impl do
  use BigChor.Chorex, :worker1

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker2Impl do
  use BigChor.Chorex, :worker2

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker3Impl do
  use BigChor.Chorex, :worker3

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker4Impl do
  use BigChor.Chorex, :worker4

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker5Impl do
  use BigChor.Chorex, :worker5

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker6Impl do
  use BigChor.Chorex, :worker6

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker7Impl do
  use BigChor.Chorex, :worker7

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker8Impl do
  use BigChor.Chorex, :worker8

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker9Impl do
  use BigChor.Chorex, :worker9

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker10Impl do
  use BigChor.Chorex, :worker10

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker11Impl do
  use BigChor.Chorex, :worker11

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker12Impl do
  use BigChor.Chorex, :worker12

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker13Impl do
  use BigChor.Chorex, :worker13

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker14Impl do
  use BigChor.Chorex, :worker14

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker15Impl do
  use BigChor.Chorex, :worker15

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker16Impl do
  use BigChor.Chorex, :worker16

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker17Impl do
  use BigChor.Chorex, :worker17

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker18Impl do
  use BigChor.Chorex, :worker18

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker19Impl do
  use BigChor.Chorex, :worker19

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker20Impl do
  use BigChor.Chorex, :worker20

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker21Impl do
  use BigChor.Chorex, :worker21

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker22Impl do
  use BigChor.Chorex, :worker22

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker23Impl do
  use BigChor.Chorex, :worker23

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker24Impl do
  use BigChor.Chorex, :worker24

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker25Impl do
  use BigChor.Chorex, :worker25

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker26Impl do
  use BigChor.Chorex, :worker26

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker27Impl do
  use BigChor.Chorex, :worker27

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker28Impl do
  use BigChor.Chorex, :worker28

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker29Impl do
  use BigChor.Chorex, :worker29

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker30Impl do
  use BigChor.Chorex, :worker30

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker31Impl do
  use BigChor.Chorex, :worker31

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker32Impl do
  use BigChor.Chorex, :worker32

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker33Impl do
  use BigChor.Chorex, :worker33

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker34Impl do
  use BigChor.Chorex, :worker34

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker35Impl do
  use BigChor.Chorex, :worker35

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker36Impl do
  use BigChor.Chorex, :worker36

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker37Impl do
  use BigChor.Chorex, :worker37

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker38Impl do
  use BigChor.Chorex, :worker38

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker39Impl do
  use BigChor.Chorex, :worker39

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker40Impl do
  use BigChor.Chorex, :worker40

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker41Impl do
  use BigChor.Chorex, :worker41

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker42Impl do
  use BigChor.Chorex, :worker42

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker43Impl do
  use BigChor.Chorex, :worker43

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker44Impl do
  use BigChor.Chorex, :worker44

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker45Impl do
  use BigChor.Chorex, :worker45

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker46Impl do
  use BigChor.Chorex, :worker46

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker47Impl do
  use BigChor.Chorex, :worker47

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker48Impl do
  use BigChor.Chorex, :worker48

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker49Impl do
  use BigChor.Chorex, :worker49

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker50Impl do
  use BigChor.Chorex, :worker50

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker51Impl do
  use BigChor.Chorex, :worker51

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker52Impl do
  use BigChor.Chorex, :worker52

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker53Impl do
  use BigChor.Chorex, :worker53

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker54Impl do
  use BigChor.Chorex, :worker54

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker55Impl do
  use BigChor.Chorex, :worker55

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker56Impl do
  use BigChor.Chorex, :worker56

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker57Impl do
  use BigChor.Chorex, :worker57

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker58Impl do
  use BigChor.Chorex, :worker58

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker59Impl do
  use BigChor.Chorex, :worker59

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker60Impl do
  use BigChor.Chorex, :worker60

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker61Impl do
  use BigChor.Chorex, :worker61

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker62Impl do
  use BigChor.Chorex, :worker62

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker63Impl do
  use BigChor.Chorex, :worker63

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker64Impl do
  use BigChor.Chorex, :worker64

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker65Impl do
  use BigChor.Chorex, :worker65

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker66Impl do
  use BigChor.Chorex, :worker66

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker67Impl do
  use BigChor.Chorex, :worker67

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker68Impl do
  use BigChor.Chorex, :worker68

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker69Impl do
  use BigChor.Chorex, :worker69

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker70Impl do
  use BigChor.Chorex, :worker70

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker71Impl do
  use BigChor.Chorex, :worker71

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker72Impl do
  use BigChor.Chorex, :worker72

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker73Impl do
  use BigChor.Chorex, :worker73

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker74Impl do
  use BigChor.Chorex, :worker74

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker75Impl do
  use BigChor.Chorex, :worker75

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker76Impl do
  use BigChor.Chorex, :worker76

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker77Impl do
  use BigChor.Chorex, :worker77

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker78Impl do
  use BigChor.Chorex, :worker78

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker79Impl do
  use BigChor.Chorex, :worker79

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker80Impl do
  use BigChor.Chorex, :worker80

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker81Impl do
  use BigChor.Chorex, :worker81

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker82Impl do
  use BigChor.Chorex, :worker82

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker83Impl do
  use BigChor.Chorex, :worker83

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker84Impl do
  use BigChor.Chorex, :worker84

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker85Impl do
  use BigChor.Chorex, :worker85

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker86Impl do
  use BigChor.Chorex, :worker86

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker87Impl do
  use BigChor.Chorex, :worker87

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker88Impl do
  use BigChor.Chorex, :worker88

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker89Impl do
  use BigChor.Chorex, :worker89

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker90Impl do
  use BigChor.Chorex, :worker90

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker91Impl do
  use BigChor.Chorex, :worker91

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker92Impl do
  use BigChor.Chorex, :worker92

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker93Impl do
  use BigChor.Chorex, :worker93

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker94Impl do
  use BigChor.Chorex, :worker94

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker95Impl do
  use BigChor.Chorex, :worker95

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker96Impl do
  use BigChor.Chorex, :worker96

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker97Impl do
  use BigChor.Chorex, :worker97

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker98Impl do
  use BigChor.Chorex, :worker98

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker99Impl do
  use BigChor.Chorex, :worker99

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end
defmodule Worker100Impl do
  use BigChor.Chorex, :worker100

  @impl true
  def work_hard(x) do
    :crypto.hash(:sha256, to_string(x))
  end
end


defmodule DispatchImpl do
  use BigChor.Chorex, :dispatch
end

defmodule BigRunner do
  def run(start \\ 1, use_try? \\ true) do
    actor_map = %{
      Worker1 => Worker1Impl,
      Worker2 => Worker2Impl,
      Worker3 => Worker3Impl,
      Worker4 => Worker4Impl,
      Worker5 => Worker5Impl,
      Worker6 => Worker6Impl,
      Worker7 => Worker7Impl,
      Worker8 => Worker8Impl,
      Worker9 => Worker9Impl,
      Worker10 => Worker10Impl,
      Worker11 => Worker11Impl,
      Worker12 => Worker12Impl,
      Worker13 => Worker13Impl,
      Worker14 => Worker14Impl,
      Worker15 => Worker15Impl,
      Worker16 => Worker16Impl,
      Worker17 => Worker17Impl,
      Worker18 => Worker18Impl,
      Worker19 => Worker19Impl,
      Worker20 => Worker20Impl,
      Worker21 => Worker21Impl,
      Worker22 => Worker22Impl,
      Worker23 => Worker23Impl,
      Worker24 => Worker24Impl,
      Worker25 => Worker25Impl,
      Worker26 => Worker26Impl,
      Worker27 => Worker27Impl,
      Worker28 => Worker28Impl,
      Worker29 => Worker29Impl,
      Worker30 => Worker30Impl,
      Worker31 => Worker31Impl,
      Worker32 => Worker32Impl,
      Worker33 => Worker33Impl,
      Worker34 => Worker34Impl,
      Worker35 => Worker35Impl,
      Worker36 => Worker36Impl,
      Worker37 => Worker37Impl,
      Worker38 => Worker38Impl,
      Worker39 => Worker39Impl,
      Worker40 => Worker40Impl,
      Worker41 => Worker41Impl,
      Worker42 => Worker42Impl,
      Worker43 => Worker43Impl,
      Worker44 => Worker44Impl,
      Worker45 => Worker45Impl,
      Worker46 => Worker46Impl,
      Worker47 => Worker47Impl,
      Worker48 => Worker48Impl,
      Worker49 => Worker49Impl,
      Worker50 => Worker50Impl,
      Worker51 => Worker51Impl,
      Worker52 => Worker52Impl,
      Worker53 => Worker53Impl,
      Worker54 => Worker54Impl,
      Worker55 => Worker55Impl,
      Worker56 => Worker56Impl,
      Worker57 => Worker57Impl,
      Worker58 => Worker58Impl,
      Worker59 => Worker59Impl,
      Worker60 => Worker60Impl,
      Worker61 => Worker61Impl,
      Worker62 => Worker62Impl,
      Worker63 => Worker63Impl,
      Worker64 => Worker64Impl,
      Worker65 => Worker65Impl,
      Worker66 => Worker66Impl,
      Worker67 => Worker67Impl,
      Worker68 => Worker68Impl,
      Worker69 => Worker69Impl,
      Worker70 => Worker70Impl,
      Worker71 => Worker71Impl,
      Worker72 => Worker72Impl,
      Worker73 => Worker73Impl,
      Worker74 => Worker74Impl,
      Worker75 => Worker75Impl,
      Worker76 => Worker76Impl,
      Worker77 => Worker77Impl,
      Worker78 => Worker78Impl,
      Worker79 => Worker79Impl,
      Worker80 => Worker80Impl,
      Worker81 => Worker81Impl,
      Worker82 => Worker82Impl,
      Worker83 => Worker83Impl,
      Worker84 => Worker84Impl,
      Worker85 => Worker85Impl,
      Worker86 => Worker86Impl,
      Worker87 => Worker87Impl,
      Worker88 => Worker88Impl,
      Worker89 => Worker89Impl,
      Worker90 => Worker90Impl,
      Worker91 => Worker91Impl,
      Worker92 => Worker92Impl,
      Worker93 => Worker93Impl,
      Worker94 => Worker94Impl,
      Worker95 => Worker95Impl,
      Worker96 => Worker96Impl,
      Worker97 => Worker97Impl,
      Worker98 => Worker98Impl,
      Worker99 => Worker99Impl,
      Worker100 => Worker100Impl,
      Dispatch => DispatchImpl
    }

    Chorex.start(BigChor.Chorex, actor_map, [start, use_try?])

    receive do
      {:chorex_return, Worker1, _} = m ->
        m
    end
  end
end

