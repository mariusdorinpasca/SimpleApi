using Xunit;
using SimpleApi.Controllers;
using System.Linq;

namespace SimpleApi.Test;

public class UnitTest1
{

    WeatherForecastController controller = new WeatherForecastController();


    [Fact]
     public void FirstForecastReturnsMarius()
     {
        var result = controller.Get();
        var myValue = result.First();
        Assert.Contains(myValue.Summary, WeatherForecastController.Summaries);
    }

    [Fact]
    public void Test1()
    {

    }
}