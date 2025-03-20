class FailIfSlowerThanFormatter
  RSpec::Core::Formatters.register self, :example_started, :example_passed, :example_failed

  def initialize(output)
    @output = output
    @example_start_time = {}
    @slow_threshold = 0.01
  end


  def example_started(notification)
    @example_start_time[notification.example.id] = Time.now
  end

  def example_passed(notification)
    check_and_fail_if_slow(notification)
  end

  def example_failed(notification)
    @output.puts "❌ Failed: #{notification.example.description}"
  end

  private

  def check_and_fail_if_slow(notification)
    start_time = @example_start_time.delete(notification.example.id)
    return unless start_time

    elapsed_time = Time.now - start_time

    if elapsed_time > @slow_threshold
      @output.puts "❌ SLOW TEST: #{notification.example.full_description} took #{elapsed_time.round(4)} seconds."
      notification.example.execution_result.status = :failed

    else
      @output.puts "✅ Passed: #{notification.example.full_description}"
    end
  end
end

RSpec.configure do |config|
  config.before(:suite) do
    config.add_formatter FailIfSlowerThanFormatter
  end
end