module Charts

  class Overview

    def self.[](project)
      series = [ "Coverage", "Errors", "Builds" ].map { |t|
        data = (1..28).map { |day|
          if rand < 0.5
            [ day.days.ago.to_i * 1000, rand(80) + 20.0 ]
          end
        }.compact
        { :name => t, :data => data }
      }
      {
        :chart => {
          :renderTo => 'chart',
          :type => 'spline',
          :zoomType => 'x'
        },
        :credits => {
          :enabled => false
        },
        :plotOptions => { :series => { :animation => { :duration => 100, :easing => :linear } } },
        :title => {
          :text => "Overview"
        },
        :xAxis => {
          :type => 'datetime',
          :maxZoom => 24 * 3600000
        },
        :yAxis => {
          :title => { :text => "Coverage" },
          :max => 100
        },
        :series => series
      }
    end

  end

end
