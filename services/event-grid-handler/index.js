module.exports = async function (context, eventGridEvent) {
    const orderRate = eventGridEvent.data.orderRate;

    if (orderRate > 100) {
        context.log("High order rate detected. Triggering scale event.");

        // TODO: Push to Azure Queue
    }
};
