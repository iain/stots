module Charts

  class Errors

    def self.[](project)
      query = project.airbrake_errors.group("date").select("COUNT(airbrake_errors.id) AS count, DATE(airbrake_errors.occurred_at) AS date")
      series = { false => "Unresolved", true => "Resolved" }.map do |v, name|
        data = query.where(:resolved => v).map { |x| [ Time.parse(x[:date]).to_i * 1000, x[:count] ] }
        { :name => name, :data => data, :pointInterval => 24 * 3600 * 1000 }
      end
      {
        :chart => {
          :renderTo => 'chart',
          :type => 'column',
          :zoomType => 'x',
          :plotBorderWidth => 1
        },
        :credits => {
          :enabled => false
        },
        :plotOptions => {
          :series => { :animation => { :duration => 100, :easing => :linear } },
          :column => { :shadow => false, :groupPadding => 0, :pointPadding => 0, :borderWidth => 0, :stacking => "normal" }
        },
        :title => {
          :text => "Errors"
        },
        :xAxis => {
          :type => 'datetime',
          :maxZoom => 24 * 3600000,
          :tickWidth => 1,
          :lineWitdh => 1,
          :max => 1.day.from_now.to_i * 1000,
          :minorTickInterval => 'auto'
        },
        :yAxis => {
          :title => { :text => "Amount" },
          :min => 0,
          :tickWidth => 1,
          :lineWitdh => 1
        },
        :series => series
      }
    end

  end

end
