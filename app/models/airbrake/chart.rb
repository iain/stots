class Airbrake::Chart

  def self.[](project)
    query = project.airbrake_errors.by_date
    series = { false => "Unresolved", true => "Resolved" }.map do |v, name|
      data = query.resolved(v).map { |x| [ js_timestamp(Time.parse(x[:date])), x[:count] ] }
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
        :max => js_timestamp(1.day.from_now),
        :minorTickInterval => 'auto',
        :plotBands => plotbands(project)
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

  def self.plotbands(project)
    project.airbrake_deploys.map do |deploy|
      {
        :from => js_timestamp(deploy.deployed_at - 5.hours),
        :to => js_timestamp(deploy.deployed_at + 5.hours),
        :color => 'rgba(40, 210, 40, 0.5)'
      }
    end
  end

  def self.js_timestamp(time)
    time.to_time.to_i * 1000
  end

end
