module Store
  module OrdersHelper
    def humanized_order_status(status)
      case status
      when 'awaiting_routing', 'awaiting_shipment', 'partially_shipped'
        'Processing'
      when 'shipped'
        'In Transit'
      when 'cancelled', 'manual_intervention_required', 'completed'
        status.humanize
      end
    end

    def quantified_shipment_status(shipment)
      if shipment.is_a?(PendingShipment)
        25
      else
        75
      end
    end

    def humanized_shipment_status(shipment)
      if shipment.is_a?(PendingShipment)
        'awaiting shipment'
      elsif shipment.is_a?(FinalizedShipment) && shipment.delivered_at.nil?
        'in transit'
      else
        'delivered'
      end
    end
  end
end
