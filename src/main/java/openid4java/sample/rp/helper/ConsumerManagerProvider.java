package openid4java.sample.rp.helper;

import org.openid4java.consumer.ConsumerManager;

public class ConsumerManagerProvider {

	private static final ConsumerManager INSTANCE = new ConsumerManager();

	public static ConsumerManager getConsumerManager() {
		return INSTANCE;
	}

}
