module Charts

  class Overview

    def self.[](project)
      series = [ "Coverage", "Errors", "Builds" ].map { |t|
        data = (1..28).map { |day|
          if rand < 0.5
            [ Time.utc(2012, 1, day).to_i * 1000, rand(80) + 20.0 ]
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
